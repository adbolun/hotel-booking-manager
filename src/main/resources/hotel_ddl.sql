CREATE TABLE IF NOT EXISTS "role"
(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    user_role VARCHAR(24) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS gender
(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    gender_type VARCHAR(14) NOT NULL
);

CREATE TABLE IF NOT EXISTS user_detail
(
    id BIGINT PRIMARY KEY ,
    contact_number VARCHAR(64) UNIQUE NOT NULL ,
    photo VARCHAR(128),
    birthdate DATE NOT NULL ,
    money INT NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS "user"
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(64) NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    email VARCHAR(64) UNIQUE NOT NULL,
    user_password VARCHAR(28) NOT NULL,
    role_id INT NOT NULL REFERENCES "role" (id),
    gender_id INT NOT NULL REFERENCES gender (id),
    user_detail_id BIGINT UNIQUE REFERENCES user_detail (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS apartment_type
(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    ap_type VARCHAR(24) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS apartment_status
(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    ap_status VARCHAR(24) UNIQUE NOT NULL --(available, occupied)
);

CREATE TABLE IF NOT EXISTS apartment
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    number_of_rooms INT NOT NULL ,
    number_of_seats INT NOT NULL ,
    price_per_hour NUMERIC NOT NULL ,
    photo VARCHAR UNIQUE NOT NULL,
    apartment_status_id INT NOT NULL REFERENCES apartment_status (id),
    apartment_type_id INT NOT NULL REFERENCES apartment_type (id)
);

CREATE TABLE IF NOT EXISTS order_status
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    status VARCHAR(24) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS "order"
(
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    check_in TIMESTAMP NOT NULL ,
    check_out TIMESTAMP NOT NULL ,
    user_id BIGINT NOT NULL REFERENCES "user" (id) ,
    order_status_id BIGINT NOT NULL REFERENCES order_status (id),
    apartment_id BIGINT NOT NULL REFERENCES apartment (id)
);


CREATE UNIQUE INDEX user_email_idx ON "user" (email);

CREATE INDEX user_password_idx ON "user" (user_password);

CREATE INDEX apartment_price_idx ON apartment (price_per_hour);

CREATE UNIQUE INDEX apartment_status_idx ON apartment_status (ap_status);

CREATE INDEX apartment_status_id_idx ON apartment (apartment_status_id);

CREATE UNIQUE INDEX apartment_type_idx ON apartment_type (ap_type);

CREATE INDEX apartment_type_id_idx ON apartment (apartment_type_id);

CREATE INDEX number_of_seats_idx ON apartment (number_of_seats);

CREATE UNIQUE INDEX order_status_idx ON order_status (status);

CREATE INDEX order_status_id_idx ON "order" (order_status_id);

