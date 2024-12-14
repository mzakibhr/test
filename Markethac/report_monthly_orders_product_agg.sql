with cp as(
  select * 
  from `bigquery-public-data.thelook_ecommerce.order_items`
  where status = "Complete"
)

Select 
  DATE_TRUNC(cp.created_at, MONTH) as month,
  p.name as product_name,
  sum(cp.sale_price) as revenue 
from cp
INNER JOIN `bigquery-public-data.thelook_ecommerce.products` p 
on cp.product_id = p.id
group by 1, 2
order by month asc, revenue desc

/*
Penjelasan:

with cp as: merupakan CTE untuk memfilter terlebih dahulu yang memiliki status = "Complete" dari table order_items, yang dapat dianggap sebagai penjualan

query utama,
Select: memilih kolom cp.created_at yang sudah dilakukan DATE_TRUNC berdasarkan bulan dari CTE cp, kolom p.name yang merupakan kolom nama produk dari tabel products, kolom cp.sale_price yang dilakukan sum untuk menjumlahkan penjualan

From cp: mengakses CTE cp

Inner Join: melakukan join secara inner dengan key product_id dari CTE cp dan key id dari table product

Group by 1,2: melakukan group berdasarkan month dan product_name

order by month asc, revenue desc: melakukan pengurutan berdasarkan kolom month dari kecil ke besar, dan kolom revenue dari besar ke kecil

*/