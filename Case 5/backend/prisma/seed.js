const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
  // Customers
  const customer1 = await prisma.customer.create({
    data: { customer_name: "Selim Kuz", email: "selim.kuz@icloud.com", password: "hashedpass1", created_at: new Date() }
  });
  const customer2 = await prisma.customer.create({
    data: { customer_name: "Havvanur Culer", email: "havvanur.culer@icloud.com", password: "hashedpass2", created_at: new Date() }
  });

  // DeviceProfiles
  const deviceProfile1 = await prisma.deviceProfile.create({
    data: { device_type: "modem", expected_daily_mb_min: 100, expected_daily_mb_max: 500, roaming_expected: false }
  });
  const deviceProfile2 = await prisma.deviceProfile.create({
    data: { device_type: "sensor", expected_daily_mb_min: 10, expected_daily_mb_max: 50, roaming_expected: true }
  });

  // IotPlans
  const iotPlan1 = await prisma.iotPlan.create({
    data: { plan_name: "Standart", monthly_quota_mb: 10000, monthly_price: 49.99, overage_per_mb: 0.05, apn: "internet", created_at: new Date() }
  });
  const iotPlan2 = await prisma.iotPlan.create({
    data: { plan_name: "Premium", monthly_quota_mb: 50000, monthly_price: 149.99, overage_per_mb: 0.03, apn: "premium", created_at: new Date() }
  });

  // AddOnPacks
  const addOnPack1 = await prisma.addOnPack.create({
    data: { name: "Ek 1GB", extra_mb: 1000, price: 9.99, apn: "internet", created_at: new Date() }
  });
  const addOnPack2 = await prisma.addOnPack.create({
    data: { name: "Ek 5GB", extra_mb: 5000, price: 39.99, apn: "premium", created_at: new Date() }
  });

  // Sims
  const sim1 = await prisma.sim.create({
    data: { customer_id: customer1.customer_id, device_type: deviceProfile1.device_type, apn: "internet", plan_id: iotPlan1.plan_id, status: "active", city: "İstanbul", created_at: new Date(), updated_at: new Date() }
  });
  const sim2 = await prisma.sim.create({
    data: { customer_id: customer2.customer_id, device_type: deviceProfile2.device_type, apn: "premium", plan_id: iotPlan2.plan_id, status: "inactive", city: "Ankara", created_at: new Date(), updated_at: new Date() }
  });

  // Usage30d
  await prisma.usage30d.create({
    data: { sim_id: sim1.sim_id, timestamp: new Date(), mb_used: 500, roaming_mb: 0, created_at: new Date() }
  });
  await prisma.usage30d.create({
    data: { sim_id: sim2.sim_id, timestamp: new Date(), mb_used: 20, roaming_mb: 5, created_at: new Date() }
  });

  // SimAddons
  await prisma.simAddon.create({
    data: { sim_id: sim1.sim_id, addon_id: addOnPack1.addon_id, purchased_at: new Date(), expires_at: new Date(Date.now() + 30*24*60*60*1000), status: "active" }
  });
  await prisma.simAddon.create({
    data: { sim_id: sim2.sim_id, addon_id: addOnPack2.addon_id, purchased_at: new Date(), expires_at: new Date(Date.now() + 30*24*60*60*1000), status: "active" }
  });

  // ActionsLog
  await prisma.actionsLog.create({
    data: { action_id: "act1", sim_id: sim1.sim_id, action: "activate", reason: "yeni sim", created_at: new Date(), actor: "admin", status: "success", metadata: {} }
  });
  await prisma.actionsLog.create({
    data: { action_id: "act2", sim_id: sim2.sim_id, action: "deactivate", reason: "iptal", created_at: new Date(), actor: "admin", status: "success", metadata: {} }
  });

  // PlanAddOnPack
  await prisma.planAddOnPack.create({
    data: { plan_id: iotPlan1.plan_id, addon_id: addOnPack1.addon_id }
  });
  await prisma.planAddOnPack.create({
    data: { plan_id: iotPlan2.plan_id, addon_id: addOnPack2.addon_id }
  });
}

main()
  .catch(e => {
    console.error(e);
    process.exit(1);
  })
  .finally(() => prisma.$disconnect());