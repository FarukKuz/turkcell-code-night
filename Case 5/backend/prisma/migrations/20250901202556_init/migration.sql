/*
  Warnings:

  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE "public"."User";

-- CreateTable
CREATE TABLE "public"."Customer" (
    "customer_id" SERIAL NOT NULL,
    "customer_name" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Customer_pkey" PRIMARY KEY ("customer_id")
);

-- CreateTable
CREATE TABLE "public"."Sim" (
    "sim_id" SERIAL NOT NULL,
    "customer_id" INTEGER NOT NULL,
    "device_type" TEXT NOT NULL,
    "apn" TEXT NOT NULL,
    "plan_id" INTEGER,
    "status" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Sim_pkey" PRIMARY KEY ("sim_id")
);

-- CreateTable
CREATE TABLE "public"."IotPlan" (
    "plan_id" SERIAL NOT NULL,
    "plan_name" TEXT NOT NULL,
    "monthly_quota_mb" INTEGER NOT NULL,
    "monthly_price" DECIMAL(10,2) NOT NULL,
    "overage_per_mb" DECIMAL(5,3) NOT NULL,
    "apn" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "IotPlan_pkey" PRIMARY KEY ("plan_id")
);

-- CreateTable
CREATE TABLE "public"."Usage30d" (
    "id" SERIAL NOT NULL,
    "sim_id" INTEGER NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL,
    "mb_used" INTEGER NOT NULL,
    "roaming_mb" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Usage30d_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."DeviceProfile" (
    "device_type" TEXT NOT NULL,
    "expected_daily_mb_min" INTEGER NOT NULL,
    "expected_daily_mb_max" INTEGER NOT NULL,
    "roaming_expected" BOOLEAN NOT NULL,

    CONSTRAINT "DeviceProfile_pkey" PRIMARY KEY ("device_type")
);

-- CreateTable
CREATE TABLE "public"."AddOnPack" (
    "addon_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "extra_mb" INTEGER NOT NULL,
    "price" DECIMAL(10,2) NOT NULL,
    "apn" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AddOnPack_pkey" PRIMARY KEY ("addon_id")
);

-- CreateTable
CREATE TABLE "public"."SimAddon" (
    "id" SERIAL NOT NULL,
    "sim_id" INTEGER NOT NULL,
    "addon_id" INTEGER NOT NULL,
    "purchased_at" TIMESTAMP(3) NOT NULL,
    "expires_at" TIMESTAMP(3) NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'active',

    CONSTRAINT "SimAddon_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."ActionsLog" (
    "action_id" TEXT NOT NULL,
    "sim_id" INTEGER NOT NULL,
    "action" TEXT NOT NULL,
    "reason" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "actor" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "metadata" JSONB NOT NULL,

    CONSTRAINT "ActionsLog_pkey" PRIMARY KEY ("action_id")
);

-- CreateTable
CREATE TABLE "public"."PlanAddOnPack" (
    "id" SERIAL NOT NULL,
    "plan_id" INTEGER NOT NULL,
    "addon_id" INTEGER NOT NULL,

    CONSTRAINT "PlanAddOnPack_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "public"."Sim" ADD CONSTRAINT "Sim_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "public"."Customer"("customer_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Sim" ADD CONSTRAINT "Sim_plan_id_fkey" FOREIGN KEY ("plan_id") REFERENCES "public"."IotPlan"("plan_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Sim" ADD CONSTRAINT "Sim_device_type_fkey" FOREIGN KEY ("device_type") REFERENCES "public"."DeviceProfile"("device_type") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Usage30d" ADD CONSTRAINT "Usage30d_sim_id_fkey" FOREIGN KEY ("sim_id") REFERENCES "public"."Sim"("sim_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."SimAddon" ADD CONSTRAINT "SimAddon_sim_id_fkey" FOREIGN KEY ("sim_id") REFERENCES "public"."Sim"("sim_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."SimAddon" ADD CONSTRAINT "SimAddon_addon_id_fkey" FOREIGN KEY ("addon_id") REFERENCES "public"."AddOnPack"("addon_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ActionsLog" ADD CONSTRAINT "ActionsLog_sim_id_fkey" FOREIGN KEY ("sim_id") REFERENCES "public"."Sim"("sim_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."PlanAddOnPack" ADD CONSTRAINT "PlanAddOnPack_plan_id_fkey" FOREIGN KEY ("plan_id") REFERENCES "public"."IotPlan"("plan_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."PlanAddOnPack" ADD CONSTRAINT "PlanAddOnPack_addon_id_fkey" FOREIGN KEY ("addon_id") REFERENCES "public"."AddOnPack"("addon_id") ON DELETE RESTRICT ON UPDATE CASCADE;
