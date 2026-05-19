-- SHOPS
CREATE TABLE shops (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  name text NOT NULL,
  snap_location_id text NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- ENTRANCES
CREATE TABLE entrances (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  shop_id uuid REFERENCES shops(id) ON DELETE CASCADE,
  position jsonb NOT NULL,
  rotation jsonb NOT NULL,
  scale jsonb NOT NULL,
  updated_at timestamptz DEFAULT now()
);

-- AISLES
CREATE TABLE aisles (
  id text PRIMARY KEY,
  shop_id uuid REFERENCES shops(id) ON DELETE CASCADE,
  start_pos jsonb NOT NULL,
  end_pos jsonb NOT NULL,
  height float NOT NULL,
  width float NOT NULL,
  position jsonb NOT NULL,
  rotation jsonb NOT NULL,
  scale jsonb NOT NULL,
  updated_at timestamptz DEFAULT now()
);

-- SHELVES
CREATE TABLE shelves (
  id text PRIMARY KEY,
  shop_id uuid REFERENCES shops(id) ON DELETE CASCADE,
  aisle_id text REFERENCES aisles(id) ON DELETE CASCADE,
  shelf_num int NOT NULL,
  side text NOT NULL,
  subdiv int DEFAULT 0,
  label text NOT NULL,
  position jsonb NOT NULL,
  rotation jsonb NOT NULL,
  scale jsonb NOT NULL,
  updated_at timestamptz DEFAULT now()
);

-- BINS
CREATE TABLE bins (
  id text PRIMARY KEY,
  shop_id uuid REFERENCES shops(id) ON DELETE CASCADE,
  aisle_id text REFERENCES aisles(id) ON DELETE CASCADE,
  shelf_id text REFERENCES shelves(id) ON DELETE CASCADE,
  bin_num int NOT NULL,
  side text NOT NULL,
  position jsonb NOT NULL,
  rotation jsonb NOT NULL,
  scale jsonb NOT NULL,
  image_b64 text,
  updated_at timestamptz DEFAULT now()
);

-- PRODUCTS
CREATE TABLE products (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  shop_id uuid REFERENCES shops(id) ON DELETE CASCADE,
  name text NOT NULL,
  sku text,
  updated_at timestamptz DEFAULT now()
);

-- BIN → PRODUCT MAPPING
CREATE TABLE bin_products (
  bin_id text REFERENCES bins(id) ON DELETE CASCADE,
  product_id uuid REFERENCES products(id) ON DELETE CASCADE,
  quantity int DEFAULT 1,
  PRIMARY KEY (bin_id, product_id)
);