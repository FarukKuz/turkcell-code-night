# Turkcell Code Night Backend

## Kurulum ve Çalıştırma

### Gereksinimler
- Node.js (18+ önerilir)
- Docker Desktop (PostgreSQL için)
- Git

### Adımlar

1. **Repoyu klonlayın:**
   ```bash
   git clone https://github.com/FarukKuz/turkcell-code-night.git
   cd turkcell-code-night/Case 5/backend
   ```

2. **Bağımlılıkları yükleyin:**
   ```bash
   npm install
   ```

3. **Veritabanını başlatın (Docker ile):**
   ```bash
   docker compose up -d
   ```

4. **Ortam değişkenlerini ayarlayın:**
   - `.env` dosyasında aşağıdaki gibi olmalı:
     ```
     DATABASE_URL="postgresql://postgres:password@localhost:5432/mydb"
     JWT_SECRET="supersecretkey"
     ```

5. **Prisma migration ve client dosyalarını oluşturun:**
   ```bash
   npx prisma migrate dev --name init
   npx prisma generate
   ```

6. **Sunucuyu başlatın:**
   ```bash
   npm run dev
   ```
   veya
   ```bash
   npx nodemon src/index.js
   ```

### API Testi

- Ana endpoint: [http://localhost:3000/](http://localhost:3000/)
- Auth endpoint: [http://localhost:3000/auth](http://localhost:3000/auth)

---------------------------------------------------------------------------------------

### MEVCUT İLERLEME İÇİN

docker compose up -d

npx nodemon src/index.js


### DATABASE GÖRÜNTÜLEME

npx prisma studio

## KOD İLE GÖRÜNTÜLEME

psql -U postgres -d mydb

SELECT * FROM "Customer";