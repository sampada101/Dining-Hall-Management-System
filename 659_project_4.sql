--------------Down-----------------------
drop table if exists subshifts_saddler
drop table if exists subshifts_ernie
drop table if exists shifts 
drop table if exists shift_type_lookup 

drop table if exists shift_time_lookup 

drop table if exists shift_day_lookup 

drop table if exists student_employees 
drop table if exists supervisors 
drop table if exists dininghalls 

GO 
---------------Up--------------------------

create table dininghalls( 

    dining_id int identity not null, 

    dining_name varchar(20) not null, 

    dining_manger_firstname varchar(20),  

   dining_manager_lastname varchar(50), 

   dining_email varchar(50) not null,

    dining_address varchar(100) not null, 

    dining_no_of_employees int not null, 

    dining_capacity int not null, 

    dining_timings varchar(20), 

    constraint pk_dininghalls_dining_id PRIMARY key (dining_id), 

    CONSTRAINT u_dining_name UNIQUE (dining_name),
    CONSTRAINT u_dining_email UNIQUE (dining_email) 

) 

 
 
 
 
 
 

--------------------------------------------------- 



 
 

GO 

 
 

create table supervisors( 

    supervisor_id int identity not null, 

    supervisor_firstname varchar(20) not null, 

    supervisor_lastname varchar(20) not null, 

    supervisor_dining_id int not null, 

    supervisor_email varchar(50) not null, 

    supervisor_payperhour float DEFAULT 16.30, 

    constraint pk_supervisor_id primary key (supervisor_id), 

    constraint u_supervisor_id unique (supervisor_email) 

) 

--------------------------------------------------------- 



GO 

create table student_employees( 

    student_id int identity not null, 

    student_firstname varchar(20) not null, 

    student_lastname varchar(20) not null, 

    student_email varchar(50) not null, 

    student_dining_id int not null, 

    student_payperhour float default 15.30, 

    constraint pk_student_id primary key(student_id), 

    constraint u_student_email unique (student_email), 

    constraint fk_student_dining_id FOREIGN KEY (student_dining_id) 

    REFERENCES dininghalls(dining_id)  

 
 

) 

 
 
 

---------------------------------------------------------- 




 
 

GO 

 
 

create table shift_type_lookup( 

    shift_type varchar(50) not null, 

    constraint pk_shift_type primary key (shift_type) 

) 

 
 

create table shift_time_lookup( 

    shift_time varchar(50) not null, 

    constraint pk_shift_time primary key(shift_time) 

) 

 
 

create table shift_day_lookup( 

    shift_day varchar(50) not null, 

    constraint pk_shift_day primary key (shift_day) 

) 

 
 

create table shifts( 

    shift_id int identity not null, 

    shift_student_id int not null, 

    shift_dining_id int not null, 

    shift_day varchar(50) not null, 

    shift_duration int not null default 4, 

    shift_time  varchar(50) not null, 

    shift_type varchar(50) not null, 

    shift_supervisor int not null, 

    constraint pk_shift_id PRIMARY KEY (shift_id), 

    constraint fk_shift_student_id FOREIGN KEY(shift_student_id) references student_employees(student_id), 

    constraint fk_shift_dining_id FOREIGN KEY(shift_dining_id) references dininghalls(dining_id), 

    constraint fk_shift_day FOREIGN KEY(shift_day) references shift_day_lookup(shift_day), 

    constraint fk_shift_time FOREIGN KEY(shift_time) references shift_time_lookup(shift_time), 

    constraint fk_shift_type FOREIGN KEY(shift_type) references shift_type_lookup(shift_type), 

) 

 
 

------------------------------------------------------------------------------- 
/*drop table if exists subshiftspickedby
drop table if exists subsubshifts
 create table subsubshifts(
    sub_id int identity not null, 
    sub_subbedby int not null, 
    sub_shift_id int not null,
    constraint pk_sub_id PRIMARY KEY(sub_id), 
    constraint fk_sub_subbedby FOREIGN KEY (sub_subbedby) references student_employees(student_id),
    constraint fk_sub_shift_id FOREIGN KEY(sub_shift_id) references shifts(shift_id) 
 )


 create table subshiftspickedby(
     sub_id int  not null, 
     sub_shift_id int not null,
    sub_pickedby int not null, 
    constraint fk_sub_pickedby FOREIGN KEY (sub_pickedby) references student_employees(student_id),
    constraint fk_subpick_shift_id FOREIGN KEY(sub_shift_id) references shifts(shift_id)
 )
 */
 

GO 

 
 

create table subshifts_ernie( 

    sub_id int identity not null, 
    sub_subbedby int not null, 
    sub_shift_id int not null,
     sub_pickedby int,
      constraint pk_sub_id_e PRIMARY KEY(sub_id), 
    constraint fk_sub_subbedby_e FOREIGN KEY (sub_subbedby) references student_employees(student_id),
    constraint fk_sub_shift_id_e FOREIGN KEY(sub_shift_id) references shifts(shift_id),
    constraint fk_sub_pickedby_id_e FOREIGN KEY(sub_shift_id) references student_employees(student_id)   

) 

create table subshifts_saddler( 

    sub_id int identity not null, 
    sub_subbedby int not null, 
    sub_shift_id int not null,
     sub_pickedby int,
      constraint pk_sub_id_s PRIMARY KEY(sub_id), 
    constraint fk_sub_subbedby_s FOREIGN KEY (sub_subbedby) references student_employees(student_id),
    constraint fk_sub_shift_id_s FOREIGN KEY(sub_shift_id) references shifts(shift_id),
    constraint fk_sub_pickedby_id_s FOREIGN KEY(sub_shift_id) references student_employees(student_id)   

) 

 
 
 

------------------------------------------------------------------------------------------------------------------ 

 
 

INSERT INTO shift_type_lookup (shift_type) VALUES ('Normal'); 

INSERT INTO shift_type_lookup (shift_type) VALUES ('Pizza'); 

INSERT INTO shift_type_lookup (shift_type) VALUES ('Checker'); 

INSERT INTO shift_type_lookup (shift_type) VALUES ('Dishroom'); 

 
 
 

INSERT INTO shift_time_lookup (shift_time) VALUES ('Breakfast');  

INSERT INTO shift_time_lookup (shift_time) VALUES ('Lunch'); 

INSERT INTO shift_time_lookup (shift_time) VALUES ('Dinner'); 

 
 

INSERT INTO shift_day_lookup (shift_day) VALUES ('Monday'); 

INSERT INTO shift_day_lookup (shift_day) VALUES ('Tuesday'); 

INSERT INTO shift_day_lookup (shift_day) VALUES ('Wednesday'); 

INSERT INTO shift_day_lookup (shift_day) VALUES ('Thursday'); 

INSERT INTO shift_day_lookup (shift_day) VALUES ('Friday'); 

INSERT INTO shift_day_lookup (shift_day) VALUES ('Saturday'); 

INSERT INTO shift_day_lookup (shift_day) VALUES ('Sunday'); 

 
 
 
 

INSERT INTO dininghalls (dining_name,dining_manger_firstname,dining_manager_lastname,dining_email,dining_address,dining_no_of_employees,dining_capacity,dining_timings)  

VALUES ('Ernie Davis', 'Sabrina', 'Davis-Thomas', 'erniedavismngs@syr.edu', '619 Comstock Ave, Syracuse, NY 13210', 50, 100, '7:30am - 8:00pm'); 

 
 
 

INSERT INTO dininghalls   (dining_name,dining_manger_firstname,dining_manager_lastname,dining_email,dining_address,dining_no_of_employees,dining_capacity,dining_timings) 

VALUES ('Sadler Dining Hall', 'Debbie', 'Lawson', 'sadlersmanagement@gmail.com', 'Sadler Hall, Irving Ave, Syracuse, NY 13210', 50, 100, '7:30am - 9:00pm'); 

 
 
 

INSERT INTO dininghalls  (dining_name,dining_manger_firstname,dining_manager_lastname,dining_email,dining_address,dining_no_of_employees,dining_capacity,dining_timings)  

VALUES ('Shaw Dining Hall', 'James', 'Blackmon', 'shawmanager@gmail.com', '201 Euclid Ave, Syracuse, NY 13210', 50, 100, '7:00am - 8:00pm'); 

 
 

INSERT INTO supervisors (supervisor_firstname, supervisor_lastname, supervisor_dining_id, supervisor_email, supervisor_payperhour) 

VALUES  

    ('John', 'Smith', 1, 'john.smith@example.com', 16.30), 

    ('Mary', 'Johnson', 1, 'mary.johnson@example.com', 16.30), 

    ('Michael', 'Williams', 1, 'michael.williams@example.com', 16.30), 

    ('Jessica', 'Brown', 1, 'jessica.brown@example.com', 16.30), 

    ('William', 'Jones', 1, 'william.jones@example.com', 16.30), 

    ('Jennifer', 'Lee', 1, 'jennifer.lee@example.com', 16.30), 

    ('David', 'Miller', 1, 'david.miller@example.com', 16.30), 

    ('Emily', 'Davis', 1, 'emily.davis@example.com', 16.30), 

    ('Daniel', 'Garcia', 1, 'daniel.garcia@example.com', 16.30), 

    ('Ava', 'Wilson', 1, 'ava.wilson@example.com', 16.30) 

 
 
INSERT INTO supervisors ( supervisor_firstname, supervisor_lastname, supervisor_dining_id, supervisor_email, supervisor_payperhour)
VALUES ( 'Emily', 'Brown', 2, 'emily.brown@example.com', 16.30);


INSERT INTO supervisors ( supervisor_firstname, supervisor_lastname, supervisor_dining_id, supervisor_email, supervisor_payperhour)
VALUES ( 'Oliver', 'Garcia', 2, 'oliver.garcia@example.com', 16.30);


INSERT INTO supervisors ( supervisor_firstname, supervisor_lastname, supervisor_dining_id, supervisor_email, supervisor_payperhour)
VALUES ( 'Isabella', 'Jones', 2, 'isabella.jones@example.com', 16.30);


INSERT INTO supervisors ( supervisor_firstname, supervisor_lastname, supervisor_dining_id, supervisor_email, supervisor_payperhour)
VALUES ( 'Jacob', 'Lee', 2, 'jacob.lee@example.com', 16.30);


INSERT INTO supervisors ( supervisor_firstname, supervisor_lastname, supervisor_dining_id, supervisor_email, supervisor_payperhour)
VALUES ( 'Sophia', 'Miller', 2, 'sophia.miller@example.com', 16.30);


INSERT INTO supervisors ( supervisor_firstname, supervisor_lastname, supervisor_dining_id, supervisor_email, supervisor_payperhour)
VALUES ('Ethan', 'Williams', 2, 'ethan.williams@example.com', 16.30);


INSERT INTO supervisors (supervisor_firstname, supervisor_lastname, supervisor_dining_id, supervisor_email, supervisor_payperhour)
VALUES ( 'Avery', 'Davis', 2, 'avery.davis@example.com', 16.30);


INSERT INTO supervisors ( supervisor_firstname, supervisor_lastname, supervisor_dining_id, supervisor_email, supervisor_payperhour)
VALUES ( 'Lucas', 'Johnson', 2, 'lucas.johnson@example.com', 16.30);


INSERT INTO supervisors ( supervisor_firstname, supervisor_lastname, supervisor_dining_id, supervisor_email, supervisor_payperhour)
VALUES ( 'Mia', 'Smith', 2, 'mia.smith@example.com', 16.30);


INSERT INTO supervisors ( supervisor_firstname, supervisor_lastname, supervisor_dining_id, supervisor_email, supervisor_payperhour)
VALUES ('Noah', 'Wilson', 2, 'noah.wilson@example.com', 16.30);




 

          

INSERT INTO student_employees (student_firstname, student_lastname, student_email, student_dining_id, student_payperhour) 

VALUES  

    ( 'John', 'Doe', 'john.doe@syr.edu', 1, 15.30),  

    ( 'Jane', 'Doe', 'jane.doe@syr.edu', 1, 15.30),  

    ('Bob', 'Smith', 'bob.smith@syr.edu', 1, 15.30), 

    ('Emily', 'Jones', 'emily.jones@syr.edu', 1, 15.30), 

    ( 'Michael', 'Johnson', 'michael.johnson@syr.edu', 1, 15.30), 

    ( 'Sarah', 'Williams', 'sarah.williams@syr.edu', 1, 15.30), 

    ( 'David', 'Brown', 'david.brown@syr.edu', 1, 15.30), 

    ( 'Olivia', 'Miller', 'olivia.miller@syr.edu', 1, 15.30), 

    ( 'William', 'Davis', 'william.davis@syr.edu', 1, 15.30), 

    ( 'Sophia', 'Garcia', 'sophia.garcia@syr.edu', 1, 15.30), 

    ( 'James', 'Martinez', 'james.martinez@syr.edu', 1, 15.30), 

    ( 'Isabella', 'Lee', 'isabella.lee@syr.edu', 1, 15.30), 

    ( 'Benjamin', 'Hernandez', 'benjamin.hernandez@syr.edu', 1, 15.30), 

    ( 'Avery', 'Moore', 'avery.moore@syr.edu', 1, 15.30), 

    ( 'Lucas', 'Jackson', 'lucas.jackson@syr.edu', 1, 15.30), 

    ( 'Emma', 'Martin', 'emma.martin@syr.edu', 1, 15.30), 

    ( 'Ethan', 'Lee', 'ethan.lee@syr.edu', 1, 15.30), 

    ( 'Mia', 'Perez', 'mia.perez@syr.edu', 1, 15.30), 

    ( 'Alexander', 'Robinson', 'alexander.robinson@syr.edu', 1, 15.30), 

    ( 'Madison', 'Rodriguez', 'madison.rodriguez@syr.edu', 1, 15.30), 

    ( 'Noah', 'Anderson', 'noah.anderson@syr.edu', 1, 15.30), 

    ( 'Ava', 'Thomas', 'ava.thomas@syr.edu', 1, 15.30), 

    ( 'Jacob', 'Jackson', 'jacob.jackson@syr.edu', 1, 15.30), 

    ( 'Charlotte', 'White', 'charlotte.white@syr.edu', 1, 15.30), 

    ( 'Liam', 'Harris', 'liam.harris@syr.edu', 1, 15.30), 

    ( 'Chloe', 'Martin', 'chloe.martin@syr.edu', 1, 15.30), 

    ( 'Elijah', 'Thompson', 'elijah.thompson@syr.edu', 1, 15.30), 

    ( 'Grace', 'Garcia', 'grace.garcia@syr.edu', 1, 15.30),
 
    ( 'William', 'Johnson', 'william.johnson@syr.edu', 2, 15.30), 
    ( 'Sophia', 'Brown', 'sophia.brown@syr.edu', 2, 15.30), 
    ( 'Daniel', 'Garcia', 'daniel.garcia@syr.edu', 2, 15.30),
    ( 'Ava', 'Davis', 'ava.davis@syr.edu', 2, 15.30),
    ( 'Joseph', 'Rodriguez', 'joseph.rodriguez@syr.edu', 2, 15.30),
    ( 'Olivia', 'Anderson', 'olivia.anderson@syr.edu', 2, 15.30),
    ( 'Jacob', 'White', 'jacob.white@syr.edu', 2, 15.30),
    ( 'Emily', 'Thomas', 'emily.thomas@syr.edu', 2, 15.30),
    ( 'Joshua', 'Hernandez', 'joshua.hernandez@syr.edu', 2, 15.30),
    ( 'Mia', 'Lee', 'mia.lee@syr.edu', 2, 15.30),
    ( 'Noah', 'Clark', 'noah.clark@syr.edu', 2, 15.30),
    ( 'Avery', 'Scott', 'avery.scott@syr.edu', 2, 15.30),
    ( 'Isabella', 'Green', 'isabella.green@syr.edu', 2, 15.30),
    ( 'Caleb', 'Baker', 'caleb.baker@syr.edu', 2, 15.30),
    ( 'Chloe', 'Mitchell', 'chloe.mitchell@syr.edu', 2, 15.30),
    ( 'Ethan', 'Campbell', 'ethan.campbell@syr.edu', 2, 15.30),
    ( 'Madison', 'Parker', 'madison.parker@syr.edu', 2, 15.30),
    ( 'Liam', 'Evans', 'liam.evans@syr.edu', 2, 15.30),
    ( 'Elizabeth', 'Turner', 'elizabeth.turner@syr.edu', 2, 15.30),
    ( 'Elijah', 'Collins', 'elijah.collins@syr.edu', 2, 15.30),
    ( 'Grace', 'Morgan', 'grace.morgan@syr.edu', 2, 15.30),
    ( 'Samuel', 'Murphy', 'samuel.murphy@syr.edu', 2, 15.30),
    ( 'Sofia', 'Rivera', 'sofia.rivera@syr.edu', 2, 15.30),
    ( 'Michael', 'Cook', 'michael.cook@syr.edu', 2, 15.30),
    ( 'Logan', 'Harris', 'logan.harris@syr.edu', 2, 15.30),
    ( 'Avery', 'Jones', 'avery.jones@syr.edu', 2, 15.30),
    ( 'Evelyn', 'Williams', 'evelyn.williams@syr.edu', 2,15.20),
    ( 'Aria', 'Thomas', 'aria.thomas@syr.edu', 2, 15.30)

 

INSERT INTO shifts(shift_student_id,shift_dining_id, shift_day, shift_duration, shift_time, shift_type, shift_supervisor) 

VALUES 

 
 
 

(1,1, 'Monday', 4, 'Breakfast', 'Normal', 1), 

(2,1, 'Monday', 4, 'Breakfast', 'Pizza', 1), 

(3,1, 'Monday', 4, 'Breakfast', 'Dishroom', 1), 

(4,1, 'Monday', 4, 'Breakfast', 'Checker', 1), 

 
 
 

(1,1, 'Tuesday', 4, 'Lunch', 'Normal', 2), 

(2,1, 'Tuesday', 4, 'Lunch', 'Pizza', 2), 

(3,1, 'Tuesday', 4, 'Lunch', 'Dishroom', 2), 

(4,1, 'Tuesday', 4, 'Lunch', 'Checker', 2), 

 
 
 

(1,1, 'Wednesday', 4, 'Lunch', 'Normal', 3), 

(2,1, 'Wednesday', 4, 'Lunch', 'Pizza', 3), 

(3,1, 'Wednesday', 4, 'Lunch', 'Dishroom', 3), 

(4,1, 'Wednesday', 4, 'Lunch', 'Checker', 3), 

 
 
 

(5,1, 'Thursday', 4, 'Breakfast', 'Normal', 4), 

(6,1, 'Thursday', 4, 'Breakfast', 'Pizza', 4), 

(7,1, 'Thursday', 4, 'Breakfast', 'Dishroom', 4), 

(8,1, 'Thursday', 4, 'Breakfast', 'Checker', 4), 

 
 
 

(5,1, 'Friday', 4, 'Lunch', 'Normal', 5), 

(6,1, 'Friday', 4, 'Lunch', 'Pizza', 5), 

(7,1, 'Friday', 4, 'Lunch', 'Dishroom', 5), 

(8,1, 'Friday', 4, 'Lunch', 'Checker', 5), 

 
 
 

(5,1, 'Saturday', 4, 'Dinner', 'Normal', 6), 

(6,1, 'Saturday', 4, 'Dinner', 'Pizza', 6), 

(7,1, 'Saturday', 4, 'Dinner', 'Dishroom', 6), 

(8,1, 'Saturday', 4, 'Dinner', 'Checker', 6), 

 
 
 

(9,1, 'Sunday', 4, 'Breakfast', 'Normal', 7), 

(10,1, 'Sunday', 4, 'Breakfast', 'Pizza', 7), 

(11,1, 'Sunday', 4, 'Breakfast', 'Dishroom', 7), 

(12,1, 'Sunday', 4, 'Breakfast', 'Checker', 7), 

 
 
 
 
 
 
 

(13,1, 'Monday', 4, 'Lunch', 'Normal', 1), 

(14,1, 'Monday', 4, 'Lunch', 'Pizza', 1), 

(15,1, 'Monday', 4, 'Lunch', 'Dishroom', 1), 

(16,1, 'Monday', 4, 'Lunch', 'Checker', 1), 

 
 
 

(17,1, 'Monday', 4, 'Dinner', 'Normal', 2), 

(18,1, 'Monday', 4, 'Dinner', 'Pizza', 2), 

(19,1, 'Monday', 4, 'Dinner', 'Dishroom', 2), 

(20,1, 'Monday', 4, 'Dinner', 'Checker', 2), 

 
 
 

(21,1, 'Tuesday', 4, 'Breakfast', 'Normal', 3), 

(22,1, 'Tuesday', 4, 'Breakfast', 'Pizza', 3), 

(23,1, 'Tuesday', 4, 'Breakfast', 'Dishroom', 3), 

(24,1, 'Tuesday', 4, 'Breakfast', 'Checker', 3), 

 
 
 

(13,1, 'Tuesday', 4, 'Dinner', 'Normal', 4), 

(14,1, 'Tuesday', 4, 'Dinner', 'Pizza', 4), 

(15,1, 'Tuesday', 4, 'Dinner', 'Dishroom', 4), 

(16,1, 'Tuesday', 4, 'Dinner', 'Checker', 4), 

 
 
 

(17,1, 'Wednesday', 4, 'Dinner', 'Normal', 5), 

(18,1, 'Wednesday', 4, 'Dinner', 'Pizza', 5), 

(19,1, 'Wednesday', 4, 'Dinner', 'Dishroom', 5), 

(20,1, 'Wednesday', 4, 'Dinner', 'Checker', 5), 

 
 
 

(21,1, 'Wednesday', 4, 'Breakfast', 'Normal', 6), 

(22,1, 'Wednesday', 4, 'Breakfast', 'Pizza', 6), 

(23,1, 'Wednesday', 4, 'Breakfast', 'Dishroom', 6), 

(24,1, 'Wednesday', 4, 'Breakfast', 'Checker', 6), 

 
 
 

(13,1, 'Thursday', 4, 'Lunch', 'Normal', 7), 

(14,1, 'Thursday', 4, 'Lunch', 'Pizza', 7), 

(15,1, 'Thursday', 4, 'Lunch', 'Dishroom', 7), 

(16,1, 'Thursday', 4, 'Lunch', 'Checker', 7), 

 
 
 

(17,1, 'Thursday', 4, 'Dinner', 'Normal', 8), 

(18,1, 'Thursday', 4, 'Dinner', 'Pizza', 8), 

(19,1, 'Thursday', 4, 'Dinner', 'Dishroom', 8), 

(20,1, 'Thursday', 4, 'Dinner', 'Checker', 8), 

 
 
 

(21,1, 'Friday', 4, 'Breakfast', 'Normal', 9), 

(22,1, 'Friday', 4, 'Breakfast', 'Pizza', 9), 

(23,1, 'Friday', 4, 'Breakfast', 'Dishroom', 9), 

(24,1, 'Friday', 4, 'Breakfast', 'Checker', 9), 

 
 
 

(9,1, 'Friday', 4, 'Dinner', 'Normal', 9), 

(10,1, 'Friday', 4, 'Dinner', 'Pizza', 9), 

(11,1, 'Friday', 4, 'Dinner', 'Dishroom', 9), 

(12,1, 'Friday', 4, 'Dinner', 'Checker', 9), 

 
 
 

(9,1, 'Saturday', 4, 'Breakfast', 'Normal', 6), 

(10,1, 'Saturday', 4, 'Breakfast', 'Pizza', 6), 

(11,1, 'Saturday', 4, 'Breakfast', 'Dishroom', 6), 

(12,1, 'Saturday', 4, 'Breakfast', 'Checker', 6), 

 
 
 

(25,1, 'Saturday', 4, 'Lunch', 'Normal', 6), 

(26,1, 'Saturday', 4, 'Lunch', 'Pizza', 6), 

(27,1, 'Saturday', 4, 'Lunch', 'Dishroom', 6), 

(28,1, 'Saturday', 4, 'Lunch', 'Checker', 6), 

 
 
 

(25,1, 'Sunday', 4, 'Dinner', 'Normal', 7), 

(26,1, 'Sunday', 4, 'Dinner', 'Pizza', 7), 

(27,1, 'Sunday', 4, 'Dinner', 'Dishroom', 7), 

(28,1, 'Sunday', 4, 'Dinner', 'Checker', 7), 

 
 
 

(25,1, 'Sunday', 4, 'Lunch', 'Normal', 7), 

(26,1, 'Sunday', 4, 'Lunch', 'Pizza', 7), 

(27,1, 'Sunday', 4, 'Lunch', 'Dishroom', 7), 

(28,1, 'Sunday', 4, 'Lunch', 'Checker', 7) 





INSERT INTO shifts(shift_student_id,shift_dining_id, shift_day, shift_duration, shift_time, shift_type, shift_supervisor)
VALUES


(29,2, 'Monday', 4, 'Breakfast', 'Normal', 11),
(30, 2,'Monday', 4, 'Breakfast', 'Pizza', 11),
(31, 2,'Monday', 4, 'Breakfast', 'Dishroom', 11),
(32, 2,'Monday', 4, 'Breakfast', 'Checker', 11)

INSERT INTO shifts(shift_student_id,shift_dining_id, shift_day, shift_duration, shift_time, shift_type, shift_supervisor)
VALUES

(29, 2,'Tuesday', 4, 'Lunch', 'Normal', 12),
(30, 2,'Tuesday', 4, 'Lunch', 'Pizza', 12),
(31, 2,'Tuesday', 4, 'Lunch', 'Dishroom',12),
(32, 2,'Tuesday', 4, 'Lunch', 'Checker', 12),


(29, 2,'Wednesday', 4, 'Dinner', 'Normal', 13),
(30, 2,'Wednesday', 4, 'Dinner', 'Pizza', 13),
(31, 2,'Wednesday', 4, 'Dinner', 'Dishroom', 13),
(32, 2,'Wednesday', 4, 'Dinner', 'Checker', 13),


(33, 2,'Thursday', 4, 'Breakfast', 'Normal', 14),
(34, 2,'Thursday', 4, 'Breakfast', 'Pizza', 14),
(35, 2,'Thursday', 4, 'Breakfast', 'Dishroom',14),
(36, 2,'Thursday', 4, 'Breakfast', 'Checker', 14)


INSERT INTO shifts(shift_student_id,shift_dining_id, shift_day, shift_duration, shift_time, shift_type, shift_supervisor)
VALUES

(33, 2,'Friday', 4, 'Lunch', 'Normal', 15),
(34, 2,'Friday', 4, 'Lunch', 'Pizza', 15),
(35, 2,'Friday', 4, 'Lunch', 'Dishroom', 15),
(36, 2,'Friday', 4, 'Lunch', 'Checker', 15),


(33, 2,'Saturday', 4, 'Dinner', 'Normal', 16),
(34, 2,'Saturday', 4, 'Dinner', 'Pizza', 16),
(35, 2,'Saturday', 4, 'Dinner', 'Dishroom', 16),
(36, 2,'Saturday', 4, 'Dinner', 'Checker', 16),


(37, 2,'Sunday', 4, 'Breakfast', 'Normal', 17),
(38, 2,'Sunday', 4, 'Breakfast', 'Pizza', 17),
(39, 2,'Sunday', 4, 'Breakfast', 'Dishroom', 17),
(40, 2,'Sunday', 4, 'Breakfast', 'Checker', 17)



INSERT INTO shifts(shift_student_id,shift_dining_id, shift_day, shift_duration, shift_time, shift_type, shift_supervisor)
VALUES


(41, 2,'Monday', 4, 'Lunch', 'Normal', 11),
(42, 2,'Monday', 4, 'Lunch', 'Pizza', 11),
(43, 2,'Monday', 4, 'Lunch', 'Dishroom', 11),
(44, 2,'Monday', 4, 'Lunch', 'Checker', 11),


(45, 2,'Monday', 4, 'Dinner', 'Normal', 12),
(46, 2,'Monday', 4, 'Dinner', 'Pizza', 12),
(47, 2,'Monday', 4, 'Dinner', 'Dishroom', 12),
(48, 2,'Monday', 4, 'Dinner', 'Checker', 12)

INSERT INTO shifts(shift_student_id,shift_dining_id, shift_day, shift_duration, shift_time, shift_type, shift_supervisor)
VALUES

(49, 2,'Tuesday', 4, 'Breakfast', 'Normal', 13),
(50, 2,'Tuesday', 4, 'Breakfast', 'Pizza', 13),
(51, 2,'Tuesday', 4, 'Breakfast', 'Dishroom', 13),
(52, 2,'Tuesday', 4, 'Breakfast', 'Checker', 13),


(41, 2,'Tuesday', 4, 'Lunch', 'Normal', 14),
(42, 2,'Tuesday', 4, 'Lunch', 'Pizza', 14),
(43, 2,'Tuesday', 4, 'Lunch', 'Dishroom', 14),
(44, 2,'Tuesday', 4, 'Lunch', 'Checker', 14),


(45, 2,'Wednesday', 4, 'Dinner', 'Normal', 15),
(46, 2,'Wednesday', 4, 'Dinner', 'Pizza', 15),
(47, 2,'Wednesday', 4, 'Dinner', 'Dishroom', 15),
(48, 2,'Wednesday', 4, 'Dinner', 'Checker', 15),


(49, 2,'Wednesday', 4, 'Breakfast', 'Normal', 16),
(50, 2,'Wednesday', 4, 'Breakfast', 'Pizza', 16),
(51, 2,'Wednesday', 4, 'Breakfast', 'Dishroom', 16),
(52, 2,'Wednesday', 4, 'Breakfast', 'Checker', 16),


(41, 2,'Thursday', 4, 'Lunch', 'Normal', 17),
(42, 2,'Thursday', 4, 'Lunch', 'Pizza', 17),
(43, 2,'Thursday', 4, 'Lunch', 'Dishroom', 17),
(44, 2,'Thursday', 4, 'Lunch', 'Checker', 17),


(45, 2,'Thursday', 4, 'Dinner', 'Normal', 18),
(46, 2,'Thursday', 4, 'Dinner', 'Pizza', 18),
(47, 2,'Thursday', 4, 'Dinner', 'Dishroom', 18),
(48, 2,'Thursday', 4, 'Dinner', 'Checker', 18),


(49, 2,'Friday', 4, 'Breakfast', 'Normal', 19),
(50, 2,'Friday', 4, 'Breakfast', 'Pizza', 19),
(51, 2,'Friday', 4, 'Breakfast', 'Dishroom', 19),
(52, 2,'Friday', 4, 'Breakfast', 'Dishroom', 19),


(37, 2,'Friday', 4, 'Dinner', 'Normal', 19),
(38, 2,'Friday', 4, 'Dinner', 'Pizza', 19),
(39, 2,'Friday', 4, 'Dinner', 'Dishroom', 19),
(40, 2,'Friday', 4, 'Dinner', 'Dishroom', 9),


(37, 2,'Saturday', 4, 'Breakfast', 'Normal', 16),
(38, 2,'Saturday', 4, 'Breakfast', 'Pizza',16),
(39, 2,'Saturday', 4, 'Breakfast', 'Dishroom',16),
(40, 2,'Saturday', 4, 'Breakfast', 'Checker', 16),


(53, 2,'Saturday', 4, 'Lunch', 'Normal', 16),
(54, 2,'Saturday', 4, 'Lunch', 'Pizza', 16),
(55, 2,'Saturday', 4, 'Lunch', 'Dishroom', 16),
(56, 2,'Saturday', 4, 'Lunch', 'Checker', 16),


(53, 2,'Sunday', 4, 'Dinner', 'Normal', 17),
(54, 2,'Sunday', 4, 'Dinner', 'Pizza', 17),
(55, 2,'Sunday', 4, 'Dinner', 'Dishroom', 17),
(56, 2,'Sunday', 4, 'Dinner', 'Checker', 17),


(53, 2,'Sunday', 4, 'Lunch', 'Normal', 17),
(54, 2,'Sunday', 4, 'Lunch', 'Pizza', 17),
(55, 2,'Sunday', 4, 'Lunch', 'Dishroom', 17),
(56, 2,'Sunday', 4, 'Lunch', 'Checker', 17)




 

----------------------Separatly created tables------------------------- 
drop table if EXISTS shifts_scheduled
drop table if EXISTS shifts_scheduled_ernie
drop table if EXISTS shifts_scheduled_saddler
drop table if EXISTS shifts_scheduled_shaw
drop table if EXISTS worked_hours

CREATE TABLE [dbo].[shifts_scheduled]( 

    [shift_id] [int] NOT NULL, 

    [shift_dining_id] [int] NOT NULL, 

    [shift_day] [varchar](50) NOT NULL, 

    [shift_time] [varchar](50) NOT NULL, 

    [shift_type] [varchar](50) NOT NULL, 

    [StudentName] [varchar](41) NOT NULL, 

    [supervisorname] [varchar](41) NOT NULL 

) 

CREATE TABLE [dbo].[shifts_scheduled_ernie]( 

    [shift_id] [int] NOT NULL, 

    [shift_day] [varchar](50) NOT NULL, 

    [shift_time] [varchar](50) NOT NULL, 

    [shift_type] [varchar](50) NOT NULL, 

    [StudentName] [varchar](41) NOT NULL, 

    [supervisorname] [varchar](41) NOT NULL 

) 

CREATE TABLE [dbo].[shifts_scheduled_saddler]( 

    [shift_id] [int] NOT NULL, 

    [shift_day] [varchar](50) NOT NULL, 

    [shift_time] [varchar](50) NOT NULL, 

    [shift_type] [varchar](50) NOT NULL, 

    [StudentName] [varchar](41) NOT NULL, 

    [supervisorname] [varchar](41) NOT NULL 

) 

 

CREATE TABLE [dbo].[shifts_scheduled_shaw]( 

    [shift_id] [int] NOT NULL, 

    [shift_day] [varchar](50) NOT NULL, 

    [shift_time] [varchar](50) NOT NULL, 

    [shift_type] [varchar](50) NOT NULL, 

    [StudentName] [varchar](41) NOT NULL, 

    [supervisorname] [varchar](41) NOT NULL 

) 
/*
CREATE TABLE [dbo].[worked_hours]( 

    [student_id] [int] NOT NULL, 

    [shift_dining_id] [int] NOT NULL, 

    [Student_name] [varchar](41) NOT NULL, 

    [totalhours] [int] NULL 

) 
*/
 

 

 

 

 

 

 

 

 

 

 

 

--------------------------------Stored Procedures------------------------- 
drop PROCEDURE if exists daily_shifts
GO
create  procedure daily_shifts as 

     BEGIN 

--totalshifts 

 
 

 TRUNCATE TABLE shifts_scheduled  

   

     insert into shifts_scheduled 

     select top(1000) shift_id,shift_dining_id,shift_day,shift_time ,shift_type,s2.student_firstname+' '+s2.Student_lastname as StudentName,s3.supervisor_firstname+' '+supervisor_lastname as supervisorname 

     from shifts s1 

     join student_employees s2 on s1.shift_student_id = s2.student_id 

     join supervisors s3 on s1.shift_supervisor = s3.supervisor_id 

     group by shift_day,shift_time,shift_type, s2.student_firstname,s2.student_lastname,supervisor_firstname,supervisor_lastname,shift_id,shift_dining_id 

     ORDER BY   

          CASE 

               WHEN shift_day = 'Sunday' THEN 1 

               WHEN shift_day = 'Monday' THEN 2 

               WHEN shift_day = 'Tuesday' THEN 3 

               WHEN shift_day = 'Wednesday' THEN 4 

               WHEN shift_day = 'Thursday' THEN 5 

               WHEN shift_day = 'Friday' THEN 6 

               WHEN shift_day = 'Saturday' THEN 7 

          END ASC, 

          CASE 

          when shift_time = 'Breakfast' then 1 

          when shift_time = 'Lunch' then 2 

          when shift_time = 'Dinner' then 3 

          END ASC 

 
 

---ernie 

     TRUNCATE TABLE shifts_scheduled_ernie  

      

     insert into shifts_scheduled_ernie 
     select top(1000) shift_id,shift_day,shift_time ,shift_type,s2.student_firstname+' '+s2.Student_lastname as StudentName,s3.supervisor_firstname+' '+supervisor_lastname as supervisorname  
     from shifts s1 
     join student_employees s2 on s1.shift_student_id = s2.student_id 
     join supervisors s3 on s1.shift_supervisor = s3.supervisor_id 
     where shift_dining_id = 1 
     group by shift_day,shift_time,shift_type, s2.student_firstname,s2.student_lastname,supervisor_firstname,supervisor_lastname,shift_id 
     ORDER BY   
          CASE 
               WHEN shift_day = 'Sunday' THEN 1 
               WHEN shift_day = 'Monday' THEN 2 
               WHEN shift_day = 'Tuesday' THEN 3 
               WHEN shift_day = 'Wednesday' THEN 4 
               WHEN shift_day = 'Thursday' THEN 5 
               WHEN shift_day = 'Friday' THEN 6 
               WHEN shift_day = 'Saturday' THEN 7 
          END ASC, 
          CASE 
          when shift_time = 'Breakfast' then 1 
          when shift_time = 'Lunch' then 2 
          when shift_time = 'Dinner' then 3 
          END ASC 

 
 

---saddler  

      TRUNCATE TABLE shifts_scheduled_saddler 

    

      

     insert into shifts_scheduled_saddler 

     select top(1000) shift_id,shift_day,shift_time ,shift_type,s2.student_firstname+' '+s2.Student_lastname as StudentName,s3.supervisor_firstname+' '+supervisor_lastname as supervisorname  

     from shifts s1 

     join student_employees s2 on s1.shift_student_id = s2.student_id 

     join supervisors s3 on s1.shift_supervisor = s3.supervisor_id 

     where shift_dining_id = 2 

     group by shift_day,shift_time,shift_type, s2.student_firstname,s2.student_lastname,supervisor_firstname,supervisor_lastname,shift_id 

     ORDER BY   

          CASE 

               WHEN shift_day = 'Sunday' THEN 1 

               WHEN shift_day = 'Monday' THEN 2 

               WHEN shift_day = 'Tuesday' THEN 3 

               WHEN shift_day = 'Wednesday' THEN 4 

               WHEN shift_day = 'Thursday' THEN 5 

               WHEN shift_day = 'Friday' THEN 6 

               WHEN shift_day = 'Saturday' THEN 7 

          END ASC, 

          CASE 

          when shift_time = 'Breakfast' then 1 

          when shift_time = 'Lunch' then 2 

          when shift_time = 'Dinner' then 3 

          END ASC 

 
 

---shaw 

 TRUNCATE TABLE shifts_scheduled_shaw  

      

     insert into shifts_scheduled_shaw 

     select top(1000) shift_id,shift_day,shift_time ,shift_type,s2.student_firstname+' '+s2.Student_lastname as StudentName,s3.supervisor_firstname+' '+supervisor_lastname as supervisorname  

     from shifts s1 

     join student_employees s2 on s1.shift_student_id = s2.student_id 

     join supervisors s3 on s1.shift_supervisor = s3.supervisor_id 

     where shift_dining_id = 3 

     group by shift_day,shift_time,shift_type, s2.student_firstname,s2.student_lastname,supervisor_firstname,supervisor_lastname, shift_id 

     ORDER BY   

          CASE 

               WHEN shift_day = 'Sunday' THEN 1 

               WHEN shift_day = 'Monday' THEN 2 

               WHEN shift_day = 'Tuesday' THEN 3 

               WHEN shift_day = 'Wednesday' THEN 4 

               WHEN shift_day = 'Thursday' THEN 5 

               WHEN shift_day = 'Friday' THEN 6 

               WHEN shift_day = 'Saturday' THEN 7 

          END ASC, 

          CASE 

          when shift_time = 'Breakfast' then 1 

          when shift_time = 'Lunch' then 2 

          when shift_time = 'Dinner' then 3 

          END ASC 

 
 

END 

 
 
 

--exec daily_shifts 

 
 

drop procedure if exists employee_hours 

GO 

create procedure employee_hours as 

begin 

 
 

    drop table if exists total_hours 

 
 

    select student_id,shift_dining_id, student_firstname+' '+student_lastname as Student_name, sum(shift_duration) as totalhours, STRING_AGG(shift_id,',') as shifts_inhand
        into total_hours 
        from shifts s1 

    join student_employees s2 on s1.shift_student_id = s2.student_id 

    group by student_id,student_firstname,student_lastname,shift_dining_id 

 
 

    drop table if exists worked_hours 

    select student_id,shift_dining_id, student_firstname+' '+student_lastname as Student_name, sum(shift_duration) as totalhours into worked_hours from shifts s1 

    join student_employees s2 on s1.shift_student_id = s2.student_id 

    group by student_id,student_firstname,student_lastname,shift_dining_id 

 
 

END 

 
 

exec employee_hours 


GO

drop procedure if EXISTS sub_e
GO

create procedure sub_e(
    @shift int, @subbed int
) as BEGIN
    insert into subshifts_ernie(sub_subbedby,sub_shift_id)
    values(@shift,@subbed)
END

--exec sub 1,1
GO
drop procedure if exists subpick_e
GO
create procedure subpick_e(
    @subid int, @pickedby int
) as BEGIN
    update subshifts_ernie
    set sub_pickedby = @pickedby
    where sub_id = @subid
END


--exec subpick 1,2




drop procedure if EXISTS sub_s
GO

create procedure sub_s(
    @shift int, @subbed int
) as BEGIN
    insert into subshifts_saddler(sub_subbedby,sub_shift_id)
    values(@shift,@subbed)
END

--exec sub 1,1
GO
drop procedure if exists subpick_s
GO
create procedure subpick_s(
    @subid int, @pickedby int
) as BEGIN
    update subshifts_saddler
    set sub_pickedby = @pickedby
    where sub_id = @subid
END

--exec subpick 1,2

------------------Triggers and Views------------------------------- 

 

drop view if exists v_total_hours_ernie 

GO 

 
 

create view v_total_hours_ernie as( 

select student_id,Student_name, totalhours, shifts_inhand from total_hours 

where shift_dining_id = 1 

) 

GO 

 
 

drop view if exists v_total_hours_saddler 

GO 

create view v_total_hours_saddler as( 

select student_id,Student_name, totalhours,shifts_inhand from total_hours 

where shift_dining_id = 2 

) 

GO 

 
 

drop view if exists v_total_hours_shaw 

GO 

create view v_total_hours_shaw as( 

select student_id,Student_name, totalhours from total_hours 

where shift_dining_id = 3 

) 

 
 GO

drop view if exists v_subshifts_ernie 

go 

create view v_subshifts_ernie as( 

    select sub_id,sub_shift_id,shift_dining_id,sub_subbedby,shift_day,shift_time,shift_type,sub_pickedby from subshifts_ernie s 

    join shifts_scheduled s1 on s.sub_shift_id = s1.shift_id 

)  
GO
drop view if exists v_subshifts_saddler
GO
create view v_subshifts_saddler as( 

    select sub_id,sub_shift_id,shift_dining_id,sub_subbedby,shift_day,shift_time,shift_type,sub_pickedby from subshifts_saddler s 

    join shifts_scheduled s1 on s.sub_shift_id = s1.shift_id 

)  

 GO
 

drop view if exists v_final_payments 

go 

create view v_final_payments as ( 

select *, totalhours*15.30 as payment from worked_hours  

) 

go
-------------------------------------- 

 
--------ernie------------ 


drop trigger if exists t_subbed_e 

go 

create trigger t_subbed_e 

    on subshifts_ernie 

    after INSERT 

as  BEGIN 

        if exists(select sub_shift_id from inserted) 

            BEGIN 

                 

                update worked_hours  

                                set totalhours = (select totalhours-shift_duration from (select  sub_subbedby,s1.shift_duration from shifts s1     

                                                    join inserted sb  on s1.shift_id = sb.sub_shift_id) x 

                                                    join worked_hours w ON w.student_id = x.sub_subbedby)  

                where student_id = (select sub_subbedby from inserted)                                                                

        end  

END 

 
 

drop trigger if exists t_subpicked_e 

go 

create trigger t_subpicked_e 

    on subshifts_ernie 

    after Insert,update

as  BEGIN 

        if exists(select sub_pickedby  from inserted) 

            BEGIN 

                 

                update worked_hours  

                    set totalhours = (select totalhours+shift_duration from (select  sub_pickedby,s1.shift_duration from shifts s1     

                                        join inserted sb  on s1.shift_id = sb.sub_shift_id) x 

                                        join worked_hours w ON w.student_id = x.sub_pickedby)  

                    where student_id = (select sub_pickedby from inserted)                                                                  

        end  

END 

------saddler-------------------------------


drop trigger if exists t_subbed_s 

go 

create trigger t_subbed_s 

    on subshifts_saddler 

    after INSERT 

as  BEGIN 

        if exists(select sub_shift_id from inserted) 

            BEGIN 

                 

                update worked_hours  

                                set totalhours = (select totalhours-shift_duration from (select  sub_subbedby,s1.shift_duration from shifts s1     

                                                    join inserted sb  on s1.shift_id = sb.sub_shift_id) x 

                                                    join worked_hours w ON w.student_id = x.sub_subbedby)  

                where student_id = (select sub_subbedby from inserted)                                                                

        end  

END 

 
 

drop trigger if exists t_subpicked_s 

go 

create trigger t_subpicked_s 

    on subshifts_saddler 

    after Insert,update

as  BEGIN 

        if exists(select sub_pickedby  from inserted) 

            BEGIN 

                 

                update worked_hours  

                    set totalhours = (select totalhours+shift_duration from (select  sub_pickedby,s1.shift_duration from shifts s1     

                                        join inserted sb  on s1.shift_id = sb.sub_shift_id) x 

                                        join worked_hours w ON w.student_id = x.sub_pickedby)  

                    where student_id = (select sub_pickedby from inserted)                                                                  

        end  

END 

 
 

 
 
 
 
 

 