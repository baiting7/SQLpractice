# Number of Trusted Contacts of a Customer
## Question
https://leetcode.com/problems/number-of-trusted-contacts-of-a-customer/
### Solution
```
select 
c.invoice_id, a.customer_name, c.price, a.contacts_cnt, b.trusted_contacts_cnt
from
(select a.customer_id, a.customer_name, count(b.user_id) contacts_cnt 
 from Customers a 
 left join Contacts b 
 on a.customer_id=b.user_id
 group by a.customer_id, a.customer_name)a
join (select a.customer_id, count(b.user_id) trusted_contacts_cnt  
 from Customers a 
 left join Contacts b 
 on a.customer_id=b.user_id
 and b.contact_email in (select email from Customers)
 group by a.customer_id)b
on a.customer_id=b.customer_id
join Invoices c on c.user_id = a.customer_id
order by c.invoice_id
```
### A simpler solution
```
select
    i.invoice_id,
    c.customer_name,
    i.price,
    count(con.user_id) as contacts_cnt,
    count(c2.email) as trusted_contacts_cnt
from invoices i
join customers c on c.customer_id = i.user_id
left join contacts con on con.user_id = c.customer_id
left join customers c2 on c2.email = con.contact_email
group by i.invoice_id, c.customer_name, i.price
order by i.invoice_id
```
