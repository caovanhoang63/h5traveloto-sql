select count(*) from rooms ;

select * from booking_details

explain select * from rooms;



insert into booking_details(booking_id, room_id, price) VALUES ('1','40502','300');

    insert into rooms(hotel_id, room_type_id, name) VALUES (5,12,'aaaa');



select *
from rooms inner join booking_details
on rooms.id = booking_details.room_id
where booking_id = 1;

select * from booking_details where booking_id = 1
select * from rooms where id in (10000, 2001, 20201, 20202, 30502, 40502)



select *
             from rooms inner join booking_details
             on rooms.id = booking_details.room_id
             where booking_id = 1


select * from booking_details where booking_id = 37;



select * from rooms;
select * from room_types;
select * from bookings;
select * from booking_trackings;
select * from booking_details;
select * from room_types;
select * from workers;
select * from users;
select * from hotels;







select * from rooms;


select * from bookings where bookings.id = 41






