{"EthexHouse.sol":{"content":"pragma solidity ^0.5.0;\r\n\r\n/**\r\n * (E)t)h)e)x) House Contract \r\n *  This smart-contract is the part of Ethex Lottery fair game.\r\n *  See latest version at https://github.com/ethex-bet/ethex-contracts \r\n *  http://ethex.bet\r\n */\r\n \r\n contract EthexHouse {\r\n     address payable private owner;\r\n     \r\n     constructor() public {\r\n         owner = msg.sender;\r\n     }\r\n     \r\n     modifier onlyOwner {\r\n        require(msg.sender == owner);\r\n        _;\r\n    }\r\n    \r\n    function payIn() external payable {\r\n    }\r\n    \r\n    function withdraw() external onlyOwner {\r\n        owner.transfer(address(this).balance);\r\n    }\r\n }"},"EthexJackpot.sol":{"content":"pragma solidity ^0.5.0;\n\n/**\n * (E)t)h)e)x) Jackpot Contract \n *  This smart-contract is the part of Ethex Lottery fair game.\n *  See latest version at https://github.com/ethex-bet/ethex-lottery \n *  http://ethex.bet\n */\n\ncontract EthexJackpot {\n    mapping(uint256 =\u003e address payable) tickets;\n    uint256 public numberEnd;\n    uint256 public dailyAmount;\n    uint256 public weeklyAmount;\n    uint256 public monthlyAmount;\n    uint256 public seasonalAmount;\n    bool private dailyProcessed;\n    bool private weeklyProcessed;\n    bool private monthlyProcessed;\n    bool private seasonalProcessed;\n    uint256 private dailyNumberStartPrev;\n    uint256 private weeklyNumberStartPrev;\n    uint256 private monthlyNumberStartPrev;\n    uint256 private seasonalNumberStartPrev;\n    uint256 private dailyStart;\n    uint256 private weeklyStart;\n    uint256 private monthlyStart;\n    uint256 private seasonalStart;\n    uint256 private dailyEnd;\n    uint256 private weeklyEnd;\n    uint256 private monthlyEnd;\n    uint256 private seasonalEnd;\n    uint256 private dailyNumberStart;\n    uint256 private weeklyNumberStart;\n    uint256 private monthlyNumberStart;\n    uint256 private seasonalNumberStart;\n    uint256 private dailyNumberEndPrev;\n    uint256 private weeklyNumberEndPrev;\n    uint256 private monthlyNumberEndPrev;\n    uint256 private seasonalNumberEndPrev;\n    address public lotoAddress;\n    address payable private owner;\n    \n    event Jackpot (\n        uint256 number,\n        uint256 count,\n        uint256 amount,\n        byte jackpotType\n    );\n    \n    event Ticket (\n        bytes16 indexed id,\n        uint256 number\n    );\n    \n    uint256 constant DAILY = 5000;\n    uint256 constant WEEKLY = 35000;\n    uint256 constant MONTHLY = 140000;\n    uint256 constant SEASONAL = 420000;\n    uint256 constant PRECISION = 1 ether;\n    uint256 constant DAILY_PART = 84;\n    uint256 constant WEEKLY_PART = 12;\n    uint256 constant MONTHLY_PART = 3;\n    \n    constructor() public payable {\n        owner = msg.sender;\n        dailyStart = block.number / DAILY * DAILY;\n        dailyEnd = dailyStart + DAILY;\n        dailyProcessed = true;\n        weeklyStart = block.number / WEEKLY * WEEKLY;\n        weeklyEnd = weeklyStart + WEEKLY;\n        weeklyProcessed = true;\n        monthlyStart = block.number / MONTHLY * MONTHLY;\n        monthlyEnd = monthlyStart + MONTHLY;\n        monthlyProcessed = true;\n        seasonalStart = block.number / SEASONAL * SEASONAL;\n        seasonalEnd = seasonalStart + SEASONAL;\n        seasonalProcessed = true;\n    }\n    \n    function() external payable { }\n\n    modifier onlyOwner {\n        require(msg.sender == owner);\n        _;\n    }\n    \n    modifier onlyLoto {\n        require(msg.sender == lotoAddress, \"Loto only\");\n        _;\n    }\n    \n    function migrate(address payable newContract) external onlyOwner {\n        newContract.transfer(address(this).balance);\n    }\n\n    function registerTicket(bytes16 id, address payable gamer) external onlyLoto {\n        uint256 number = numberEnd + 1;\n        if (block.number \u003e= dailyEnd) {\n            setDaily();\n            dailyNumberStart = number;\n        }\n        if (block.number \u003e= weeklyEnd) {\n            setWeekly();\n            weeklyNumberStart = number;\n        }\n        if (block.number \u003e= monthlyEnd) {\n            setMonthly();\n            monthlyNumberStart = number;\n        }\n        if (block.number \u003e= seasonalEnd) {\n            setSeasonal();\n            seasonalNumberStart = number;\n        }\n        numberEnd = number;\n        tickets[number] = gamer;\n        emit Ticket(id, number);\n    }\n    \n    function setLoto(address loto) external onlyOwner {\n        lotoAddress = loto;\n    }\n    \n    function payIn() external payable {\n        uint256 distributedAmount = dailyAmount + weeklyAmount + monthlyAmount + seasonalAmount;\n        uint256 amount = (address(this).balance - distributedAmount) / 4;\n        dailyAmount += amount;\n        weeklyAmount += amount;\n        monthlyAmount += amount;\n        seasonalAmount += amount;\n    }\n    \n    function settleJackpot() external {\n        if (block.number \u003e= dailyEnd) {\n            setDaily();\n        }\n        if (block.number \u003e= weeklyEnd) {\n            setWeekly();\n        }\n        if (block.number \u003e= monthlyEnd) {\n            setMonthly();\n        }\n        if (block.number \u003e= seasonalEnd) {\n            setSeasonal();\n        }\n        \n        if (block.number == dailyStart)\n            return;\n        \n        uint48 modulo = uint48(bytes6(blockhash(dailyStart) \u003c\u003c 29));\n        \n        uint256 dailyPayAmount;\n        uint256 weeklyPayAmount;\n        uint256 monthlyPayAmount;\n        uint256 seasonalPayAmount;\n        uint256 dailyWin;\n        uint256 weeklyWin;\n        uint256 monthlyWin;\n        uint256 seasonalWin;\n        if (dailyProcessed == false) {\n            dailyPayAmount = dailyAmount * PRECISION / DAILY_PART / PRECISION;\n            dailyAmount -= dailyPayAmount;\n            dailyProcessed = true;\n            dailyWin = getNumber(dailyNumberStartPrev, dailyNumberEndPrev, modulo);\n            emit Jackpot(dailyWin, dailyNumberEndPrev - dailyNumberStartPrev + 1, dailyPayAmount, 0x01);\n        }\n        if (weeklyProcessed == false) {\n            weeklyPayAmount = weeklyAmount * PRECISION / WEEKLY_PART / PRECISION;\n            weeklyAmount -= weeklyPayAmount;\n            weeklyProcessed = true;\n            weeklyWin = getNumber(weeklyNumberStartPrev, weeklyNumberEndPrev, modulo);\n            emit Jackpot(weeklyWin, weeklyNumberEndPrev - weeklyNumberStartPrev + 1, weeklyPayAmount, 0x02);\n        }\n        if (monthlyProcessed == false) {\n            monthlyPayAmount = monthlyAmount * PRECISION / MONTHLY_PART / PRECISION;\n            monthlyAmount -= monthlyPayAmount;\n            monthlyProcessed = true;\n            monthlyWin = getNumber(monthlyNumberStartPrev, monthlyNumberEndPrev, modulo);\n            emit Jackpot(monthlyWin, monthlyNumberEndPrev - monthlyNumberStartPrev + 1, monthlyPayAmount, 0x04);\n        }\n        if (seasonalProcessed == false) {\n            seasonalPayAmount = seasonalAmount;\n            seasonalAmount -= seasonalPayAmount;\n            seasonalProcessed = true;\n            seasonalWin = getNumber(seasonalNumberStartPrev, seasonalNumberEndPrev, modulo);\n            emit Jackpot(seasonalWin, seasonalNumberEndPrev - seasonalNumberStartPrev + 1, seasonalPayAmount, 0x08);\n        }\n        if (dailyPayAmount \u003e 0)\n            tickets[dailyWin].transfer(dailyPayAmount);\n        if (weeklyPayAmount \u003e 0)\n            tickets[weeklyWin].transfer(weeklyPayAmount);\n        if (monthlyPayAmount \u003e 0)\n            tickets[monthlyWin].transfer(monthlyPayAmount);\n        if (seasonalPayAmount \u003e 0)\n            tickets[seasonalWin].transfer(seasonalPayAmount);\n    }\n    \n    function setDaily() private {\n        dailyProcessed = dailyNumberEndPrev == numberEnd;\n        dailyStart = dailyEnd;\n        dailyEnd = dailyStart + DAILY;\n        dailyNumberStartPrev = dailyNumberStart;\n        dailyNumberEndPrev = numberEnd;\n    }\n    \n    function setWeekly() private {\n        weeklyProcessed = weeklyNumberEndPrev == numberEnd;\n        weeklyStart = weeklyEnd;\n        weeklyEnd = weeklyStart + WEEKLY;\n        weeklyNumberStartPrev = weeklyNumberStart;\n        weeklyNumberEndPrev = numberEnd;\n    }\n    \n    function setMonthly() private {\n        monthlyProcessed = monthlyNumberEndPrev == numberEnd;\n        monthlyStart = monthlyEnd;\n        monthlyEnd = monthlyStart + MONTHLY;\n        monthlyNumberStartPrev = monthlyNumberStart;\n        monthlyNumberEndPrev = numberEnd;\n    }\n    \n    function setSeasonal() private {\n        seasonalProcessed = seasonalNumberEndPrev == numberEnd;\n        seasonalStart = seasonalEnd;\n        seasonalEnd = seasonalStart + SEASONAL;\n        seasonalNumberStartPrev = seasonalNumberStart;\n        seasonalNumberEndPrev = numberEnd;\n    }\n    \n    function getNumber(uint256 startNumber, uint256 endNumber, uint48 modulo) pure private returns (uint256) {\n        return startNumber + modulo % (endNumber - startNumber + 1);\n    }\n}\n"},"EthexLoto.sol":{"content":"pragma solidity ^0.5.0;\n\n/**\n * (E)t)h)e)x) Loto Contract \n *  This smart-contract is the part of Ethex Lottery fair game.\n *  See latest version at https://github.com/ethex-bet/ethex-lottery \n *  http://ethex.bet\n */\n\nimport \"./EthexJackpot.sol\";\nimport \"./EthexHouse.sol\";\n\ncontract EthexLoto {\n    struct Bet {\n        uint256 blockNumber;\n        uint256 amount;\n        bytes16 id;\n        bytes6 bet;\n        address payable gamer;\n    }\n    \n    struct Payout {\n        uint256 amount;\n        bytes32 blockHash;\n        bytes16 id;\n        address payable gamer;\n    }\n    \n    Bet[] betArray;\n    \n    address payable public jackpotAddress;\n    address payable public houseAddress;\n    address payable private owner;\n\n    event Result (\n        uint256 amount,\n        bytes32 blockHash,\n        bytes16 indexed id,\n        address indexed gamer\n    );\n    \n    uint8 constant N = 16;\n    uint256 constant MIN_BET = 0.01 ether;\n    uint256 constant MAX_BET = 100 ether;\n    uint256 constant PRECISION = 1 ether;\n    uint256 constant JACKPOT_PERCENT = 10;\n    uint256 constant HOUSE_EDGE = 10;\n    \n    constructor(address payable jackpot, address payable house) public payable {\n        owner = msg.sender;\n        jackpotAddress = jackpot;\n        houseAddress = house;\n    }\n    \n    function() external payable { }\n    \n    modifier onlyOwner {\n        require(msg.sender == owner);\n        _;\n    }\n    \n    function placeBet(bytes22 params) external payable {\n        require(msg.value \u003e= MIN_BET, \"Bet amount should be greater or equal than minimal amount\");\n        require(msg.value \u003c= MAX_BET, \"Bet amount should be lesser or equal than maximal amount\");\n        require(bytes16(params) != 0, \"Id should not be 0\");\n        \n        bytes16 id = bytes16(params);\n        bytes6 bet = bytes6(params \u003c\u003c 128);\n        \n        uint256 jackpotFee = msg.value * JACKPOT_PERCENT * PRECISION / 100 / PRECISION;\n        uint256 houseEdgeFee = msg.value * HOUSE_EDGE * PRECISION / 100 / PRECISION;\n        betArray.push(Bet(block.number, msg.value - jackpotFee - houseEdgeFee, id, bet, msg.sender));\n        \n        uint8 markedCount;\n        for (uint i = 0; i \u003c bet.length; i++) {\n            if (bet[i] \u003e 0x13)\n                continue;\n            markedCount++;\n        }\n        if (markedCount \u003e 1)\n            EthexJackpot(jackpotAddress).registerTicket(id, msg.sender);\n        \n        EthexJackpot(jackpotAddress).payIn.value(jackpotFee)();\n        EthexHouse(houseAddress).payIn.value(houseEdgeFee)();\n    }\n    \n    function settleBets() external {\n        if (betArray.length == 0)\n            return;\n\n        Payout[] memory payouts = new Payout[](betArray.length);\n        Bet[] memory missedBets = new Bet[](betArray.length);\n        uint256 totalPayout;\n        uint i = betArray.length;\n        do {\n            i--;\n            if(betArray[i].blockNumber \u003e= block.number || betArray[i].blockNumber \u003c block.number - 256)\n                missedBets[i] = betArray[i];\n            else {\n                bytes32 blockHash = blockhash(betArray[i].blockNumber);\n                uint256 coefficient = PRECISION;\n                uint8 markedCount;\n                uint8 matchesCount;\n                uint256 divider = 1;\n                for (uint8 j = 0; j \u003c betArray[i].bet.length; j++) {\n                    if (betArray[i].bet[j] \u003e 0x13)\n                        continue;\n                    markedCount++;\n                    byte field;\n                    if (j % 2 == 0)\n                        field = blockHash[29 + j / 2] \u003e\u003e 4;\n                    else\n                        field = blockHash[29 + j / 2] \u0026 0x0F;\n                    if (betArray[i].bet[j] \u003c 0x10) {\n                        if (field == betArray[i].bet[j])\n                            matchesCount++;\n                        else\n                            divider *= 15 + N;\n                        continue;\n                    }\n                    if (betArray[i].bet[j] == 0x10) {\n                        if (field \u003e 0x09 \u0026\u0026 field \u003c 0x10) {\n                            matchesCount++;\n                            divider *= 6;\n                        } else\n                            divider *= 10 + N;\n                        continue;\n                    }\n                    if (betArray[i].bet[j] == 0x11) {\n                        if (field \u003c 0x0A) {\n                            matchesCount++;\n                            divider *= 10;\n                        } else\n                            divider *= 6 + N;\n                        continue;\n                    }\n                    if (betArray[i].bet[j] == 0x12) {\n                        if (field \u003c 0x0A \u0026\u0026 field \u0026 0x01 == 0x01) {\n                            matchesCount++;\n                            divider *= 5;\n                        } else\n                            divider *= 11 + N;\n                        continue;\n                    }\n                    if (betArray[i].bet[j] == 0x13) {\n                        if (field \u003c 0x0A \u0026\u0026 field \u0026 0x01 == 0x0) {\n                            matchesCount++;\n                            divider *= 5;\n                        } else\n                            divider *= 11 + N;\n                        continue;\n                    }\n                }\n            \n                if (matchesCount == 0) \n                    coefficient = 0;\n                else {\n                    uint256 missedCount = markedCount - matchesCount;\n                    divider *= missedCount ** missedCount;\n                    coefficient = coefficient * 16**uint256(markedCount) / divider;\n                }\n                \n                uint payoutAmount = betArray[i].amount * coefficient / PRECISION;\n                if (payoutAmount == 0 \u0026\u0026 matchesCount \u003e 0)\n                    payoutAmount = matchesCount;\n                payouts[i] = Payout(payoutAmount, blockHash, betArray[i].id, betArray[i].gamer);\n                totalPayout += payoutAmount;\n            }\n            betArray.pop();\n        } while (i \u003e 0);\n        \n        i = missedBets.length;\n        do {\n            i--;\n            if (missedBets[i].id != 0)\n                betArray.push(missedBets[i]);\n        } while (i \u003e 0);\n        \n        uint balance = address(this).balance;\n        for (i = 0; i \u003c payouts.length; i++) {\n            if (payouts[i].id \u003e 0) {\n                if (totalPayout \u003e balance)\n                    emit Result(balance * payouts[i].amount * PRECISION / totalPayout / PRECISION, payouts[i].blockHash, payouts[i].id, payouts[i].gamer);\n                else\n                    emit Result(payouts[i].amount, payouts[i].blockHash, payouts[i].id, payouts[i].gamer);\n            }\n        }\n        for (i = 0; i \u003c payouts.length; i++) {\n            if (payouts[i].amount \u003e 0) {\n                if (totalPayout \u003e balance)\n                    payouts[i].gamer.transfer(balance * payouts[i].amount * PRECISION / totalPayout / PRECISION);\n                else\n                    payouts[i].gamer.transfer(payouts[i].amount);\n            }\n        }\n    }\n    \n    function migrate(address payable newContract) external onlyOwner {\n        newContract.transfer(address(this).balance);\n    }\n}"}}