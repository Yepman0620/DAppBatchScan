[{"constant":false,"inputs":[{"name":"planBaseId","type":"bytes32"},{"name":"isOpen","type":"bool"}],"name":"togglePlanBase","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"planBaseId","type":"bytes32"}],"name":"checkPlanBase","outputs":[{"name":"","type":"uint256"},{"name":"","type":"uint256"},{"name":"","type":"uint32"},{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"planBaseId","type":"bytes32"},{"name":"lessAmount","type":"uint256"}],"name":"growHops","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"user","type":"address"}],"name":"checkPlanIdsByUser","outputs":[{"name":"","type":"bytes32[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"planBaseId","type":"bytes32"}],"name":"checkPlanIdsByPlanBase","outputs":[{"name":"","type":"bytes32[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"hopsAddress","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_address","type":"address"}],"name":"updatelessAddress","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"unpause","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"account","type":"address"}],"name":"isPauser","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"planBaseIds","outputs":[{"name":"","type":"bytes32"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"paused","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"renouncePauser","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"renounceOwnership","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"planId","type":"bytes32"}],"name":"checkPlan","outputs":[{"name":"","type":"bytes32"},{"name":"","type":"address"},{"name":"","type":"uint256"},{"name":"","type":"uint256"},{"name":"","type":"uint256"},{"name":"","type":"uint256"},{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"account","type":"address"}],"name":"addPauser","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"pause","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"planId","type":"bytes32"}],"name":"withdraw","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_address","type":"address"}],"name":"updateHopsAddress","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"isOwner","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"minimumAmount","type":"uint256"},{"name":"lockTime","type":"uint256"},{"name":"lessToHops","type":"uint32"}],"name":"addPlanBase","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"checkPlanBaseIds","outputs":[{"name":"","type":"bytes32[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"lessAddress","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"inputs":[{"name":"_hopsAddress","type":"address"},{"name":"_lessAddress","type":"address"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"name":"account","type":"address"}],"name":"Paused","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"account","type":"address"}],"name":"Unpaused","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"account","type":"address"}],"name":"PauserAdded","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"account","type":"address"}],"name":"PauserRemoved","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"previousOwner","type":"address"},{"indexed":true,"name":"newOwner","type":"address"}],"name":"OwnershipTransferred","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"planBaseId","type":"bytes32"},{"indexed":false,"name":"minimumAmount","type":"uint256"},{"indexed":false,"name":"lockTime","type":"uint256"},{"indexed":false,"name":"lessToHops","type":"uint32"},{"indexed":false,"name":"isOpen","type":"bool"}],"name":"PlanBaseEvt","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"planBaseId","type":"bytes32"},{"indexed":false,"name":"isOpen","type":"bool"}],"name":"TogglePlanBaseEvt","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"planId","type":"bytes32"},{"indexed":false,"name":"planBaseId","type":"bytes32"},{"indexed":false,"name":"plantuser","type":"address"},{"indexed":false,"name":"lessAmount","type":"uint256"},{"indexed":false,"name":"hopsAmount","type":"uint256"},{"indexed":false,"name":"lockAt","type":"uint256"},{"indexed":false,"name":"releaseAt","type":"uint256"},{"indexed":false,"name":"isWithdrawn","type":"bool"}],"name":"PlanEvt","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"planId","type":"bytes32"},{"indexed":false,"name":"plantuser","type":"address"},{"indexed":false,"name":"lessAmount","type":"uint256"},{"indexed":false,"name":"isWithdrawn","type":"bool"},{"indexed":false,"name":"withdrawAt","type":"uint256"}],"name":"WithdrawPlanEvt","type":"event"}]