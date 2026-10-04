// Business rules of gifts ("treatleme"): a student pays for a treat at a
// verified place and gives it to another verified student.

const giftMinTl = 20;
const giftMaxTl = 1000;

/// treat's share of a gift: 15 %. In kuruş it is exactly `amountTl * 15`.
const giftCommissionPercent = 15;
const giftTtl = Duration(days: 30);
const giftDailySendCap = 10;
const giftMessageMax = 140;

/// Commission and the place's share of a gift of [amountTl], in kuruş. No
/// rounding: 15 % of whole liras is always whole kuruş.
({int commissionKurus, int netKurus}) giftSplit(int amountTl) {
  final total = amountTl * 100;
  final commission = amountTl * giftCommissionPercent;
  return (commissionKurus: commission, netKurus: total - commission);
}
