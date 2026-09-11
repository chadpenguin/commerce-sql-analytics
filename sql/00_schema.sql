-- Run only in a new, disposable PostgreSQL database. Creates empty tables.
CREATE SCHEMA IF NOT EXISTS amazon_brazil;

-- ==========================================================
-- Project : Amazon Brazil Analysis
-- Database: amazon_analysis
-- Schema  : amazon_brazil
-- ==========================================================

-- ==========================================================
-- CUSTOMERS
-- ==========================================================

CREATE TABLE amazon_brazil.customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INTEGER
);

-- ==========================================================
-- ORDERS
-- ==========================================================

CREATE TABLE amazon_brazil.orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(30),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,

    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES amazon_brazil.customers(customer_id)
);

-- ==========================================================
-- PRODUCT
-- ==========================================================

CREATE TABLE amazon_brazil.product (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_length INTEGER,
    product_description_length INTEGER,
    product_photos_qty INTEGER,
    product_weight_g INTEGER,
    product_length_cm INTEGER,
    product_height_cm INTEGER,
    product_width_cm INTEGER
);

-- ==========================================================
-- SELLERS
-- ==========================================================

CREATE TABLE amazon_brazil.sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INTEGER
);

-- ==========================================================
-- PAYMENTS
-- ==========================================================

CREATE TABLE amazon_brazil.payments (
    order_id VARCHAR(50),
    payment_sequential INTEGER,
    payment_type VARCHAR(30),
    payment_installments INTEGER,
    payment_value NUMERIC(10,2),

    CONSTRAINT fk_payments_order
        FOREIGN KEY (order_id)
        REFERENCES amazon_brazil.orders(order_id)
);

-- ==========================================================
-- ORDER ITEMS
-- ==========================================================

CREATE TABLE amazon_brazil.order_items (
    order_id VARCHAR(50),
    order_item_id INTEGER,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price NUMERIC(10,2),
    freight_value NUMERIC(10,2),

    CONSTRAINT pk_order_items
        PRIMARY KEY (order_id, order_item_id),

    CONSTRAINT fk_orderitems_order
        FOREIGN KEY (order_id)
        REFERENCES amazon_brazil.orders(order_id),

    CONSTRAINT fk_orderitems_product
        FOREIGN KEY (product_id)
        REFERENCES amazon_brazil.product(product_id),

    CONSTRAINT fk_orderitems_seller
        FOREIGN KEY (seller_id)
        REFERENCES amazon_brazil.sellers(seller_id)
);
