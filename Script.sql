create type role_type as enum ('admin', 'staff', 'customer');
create type size_type as enum ('small', 'medium', 'large');
create type status_type as enum ('on-progress', 'delivered', 'canceled', 'ready-to-pick');

create table if not exists "users"(
"id" serial primary key,
"fullName" varchar (255) not null,
"email" varchar (50) unique not null,
"phoneNumber" varchar (15) not null,
"address" varchar (255) not null,
"picture" varchar (255),
"role" "role_type" default 'customer',
"password" varchar (255) not null,
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "products"(
"id" serial primary key,
"name" varchar (255) not null,
"price" numeric (12, 2) not null,
"image" varchar (255),
"description" text,
"discount" float,
"isRecommended" bool,
"qty" int not null,
"isActive" bool not null default true,
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "productSize"(
"id" serial primary key,
"size" "size_type" default null,
"additionalPrice" numeric (12, 2) not null,
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "productVariant"(
"id" serial primary key,
"name" varchar (15) not null,
"additionalPrice" numeric (12, 2) not null,
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "tags"(
"id" serial primary key,
"name" varchar (30) not null,
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "categories"(
"id" serial primary key,
"name" varchar (50) not null,
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "promo"(
"id" serial primary key,
"name" varchar (50) not null,
"code" varchar (50) not null,
"description" text,
"percentage" decimal not null,
"isExpired" bool,
"maximumPromo" int not null,
"minimumAmount" int not null,
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "productCategories"(
"id" serial primary key,
"productId" int not null,
foreign key ("productId") references "products"(id),
"categoriesId" int not null,
foreign key ("categoriesId") references "categories"(id),
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "productTags"(
"id" serial primary key,
"productId" int not null,
foreign key ("productId") references "products"(id),
"tagsId" int not null,
foreign key ("tagsId") references "tags"(id),
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "productRatings"(
"id" serial primary key,
"productId" int not null,
foreign key ("productId") references "products"(id),
"rate" int,
"reviewMessege" text,
"usersId" int not null,
foreign key ("usersId") references "users"(id),
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "orders"(
"id" serial primary key,
"usersId" int not null,
foreign key ("usersId") references "users"(id),
"orderNumber" varchar (80),
"promoId" int not null,
foreign key ("promoId") references "promo"(id),
"total" numeric (12, 2) not null,
"taxAmount" numeric (12, 2) not null,
"status" "status_type" default null,
"deliveryAddress" varchar (255) not null,
"fullName" varchar (255) not null,
"email" varchar (50) unique not null,
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "orderDetails"(
"id" serial primary key,
"ordersId" int not null,
foreign key ("ordersId") references "orders"(id),
"productId" int not null,
foreign key ("productId") references "products"(id),
"productSizeId" int not null,
foreign key ("productSizeId") references "productSize"(id),
"productVariantId" int not null,
foreign key ("productVariantId") references "productVariant"(id),
"qty" int not null,
"createdAt" timestamp default now(),
"updatedAt" timestamp 
);

create table if not exists "message"(
"id" serial primary key,
);

INSERT INTO "users" ("id", "fullName", "email", "phoneNumber", "address", "picture", "role", "password", "createdAt", "updatedAt")
VALUES
    (4, 'John Doe', 'johndoe@example.com', '1234567890', '123 Main St', 'john.jpg', 'customer', 'password1', '2023-11-08 17:32:17.309', NULL),
    (5, 'Jane Smith', 'janesmith@example.com', '9876543210', '456 Elm St', 'jane.jpg', 'customer', 'password2', '2023-11-08 17:32:17.309', NULL),
    (6, 'Alice Johnson', 'alice@example.com', '5551234567', '789 Oak St', 'alice.jpg', 'customer', 'password3', '2023-11-08 17:32:17.309', NULL),
    (7, 'Bob Brown', 'bob@example.com', '1112223333', '101 Pine St', 'bob.jpg', 'customer', 'password4', '2023-11-08 17:32:17.309', NULL),
    (8, 'Eva Wilson', 'eva@example.com', '4445556666', '202 Cedar St', 'eva.jpg', 'customer', 'password5', '2023-11-08 17:32:17.309', NULL),
    (9, 'Mike Davis', 'mike@example.com', '9998887777', '303 Walnut St', 'mike.jpg', 'customer', 'password6', '2023-11-08 17:32:17.309', NULL),
    (10, 'Sara White', 'sara@example.com', '3332221111', '505 Maple St', 'sara.jpg', 'customer', 'password7', '2023-11-08 17:32:17.309', NULL),
    (11, 'Tom Clark', 'tom@example.com', '7778889999', '707 Birch St', 'tom.jpg', 'customer', 'password8', '2023-11-08 17:32:17.309', NULL),
    (12, 'Emily Lee', 'emily@example.com', '2223334444', '909 Redwood St', 'emily.jpg', 'customer', 'password9', '2023-11-08 17:32:17.309', NULL),
    (13, 'Chris Hall', 'chris@example.com', '6665554444', '1212 Pineapple St', 'chris.jpg', 'customer', 'password10', '2023-11-08 17:32:17.309', NULL);
    
INSERT INTO "promo" ("id", "name", "code", "description", "percentage", "isExpired", "maximumPromo", "minimumAmount", "createdAt", "updatedAt")
VALUES
    (1, 'Promo 1', 'PROMO123', 'Diskon 10%', 0.10, TRUE, 50000, 100000, '2023-11-08 17:32:17.309', NULL),
    (2, 'Promo 2', 'SALE20', 'Potongan 20%', 0.20, TRUE, 30000, 50000, '2023-11-08 17:32:17.309', NULL),
    (3, 'Promo 3', 'SAVEBIG', 'Potongan 30%', 0.30, TRUE, 40000, 75000, '2023-11-08 17:32:17.309', NULL),
    (4, 'Promo 4', 'DISCOUNT40', 'Diskon 40%', 0.40, TRUE, 60000, 80000, '2023-11-08 17:32:17.309', NULL),
    (5, 'Promo 5', 'GET50OFF', 'Diskon 50%', 0.50, TRUE, 70000, 120000, '2023-11-08 17:32:17.309', NULL),
    (6, 'Promo 6', 'SPECIAL15', 'Potongan 15%', 0.15, TRUE, 45000, 90000, '2023-11-08 17:32:17.309', NULL),
    (7, 'Promo 7', 'HALFOFF', 'Diskon 50%', 0.50, TRUE, 75000, 150000, '2023-11-08 17:32:17.309', NULL),
    (8, 'Promo 8', 'SAVE25NOW', 'Potongan 25%', 0.25, TRUE, 35000, 60000, '2023-11-08 17:32:17.309', NULL),
    (9, 'Promo 9', 'FREESHIP', 'Gratis Ongkir 15%', 0.15, TRUE, 100000, 200000, '2023-11-08 17:32:17.309', NULL),
    (10, 'Promo 10', 'BIGSAVINGS', 'Diskon Besar', 0.75, TRUE, 80000, 250000, '2023-11-08 17:32:17.309', NULL),
    (11, 'Promo 11', 'SAVEMORE', 'Potongan 10%', 0.10, TRUE, 20000, 40000, '2023-11-08 17:32:17.309', NULL),
    (12, 'Promo 12', 'DISCOUNT20', 'Diskon 20%', 0.20, TRUE, 25000, 30000, '2023-11-08 17:32:17.309', NULL),
    (13, 'Promo 13', 'EXTRA5OFF', 'Ekstra 5%', 0.05, TRUE, 10000, 15000, '2023-11-08 17:32:17.309', NULL),
    (14, 'Promo 14', 'SUPER50', 'Potongan 50%', 0.50, TRUE, 70000, 100000, '2023-11-08 17:32:17.309', NULL),
    (15, 'Promo 15', 'WEEKEND10', 'Diskon 10%', 0.10, TRUE, 30000, 50000, '2023-11-08 17:32:17.309', NULL),
    (16, 'Promo 16', 'HOLIDAY15', 'Potongan 15%', 0.15, TRUE, 40000, 60000, '2023-11-08 17:32:17.309', NULL),
    (17, 'Promo 17', 'FLASHSALE30', 'Diskon Cepat 30%', 0.30, TRUE, 50000, 75000, '2023-11-08 17:32:17.309', NULL),
    (18, 'Promo 18', 'SAVEONLINE', 'Potongan 25%', 0.25, TRUE, 35000, 55000, '2023-11-08 17:32:17.309', NULL),
    (19, 'Promo 19', 'DISCOUNT15', 'Diskon 15%', 0.15, TRUE, 25000, 45000, '2023-11-08 17:32:17.309', NULL),
    (20, 'Promo 20', 'SAVETODAY', 'Potongan 20%', 0.20, TRUE, 30000, 50000, '2023-11-08 17:32:17.309', NULL);