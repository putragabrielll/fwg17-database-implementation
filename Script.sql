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
"rate" int (5),
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