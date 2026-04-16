class AssetRecommender {

  static Map<String, List<Map<String, dynamic>>> getAllAssets() {


    return {

    "stocks": getStocks(),

    "mutualFunds": getMutualFunds(),

    "etfs": getETFs(),

    "crypto": getCrypto(),

    "gold": getGold(),

    "reits": getREITs(),

    };


  }

  static List<Map<String, dynamic>> getStocks() {


    return [

    {
    "name": "Reliance Industries",
    "symbol": "RELIANCE",
    "reason": "India's largest company with leadership in telecom, energy, and retail.",
    },

    {
    "name": "TCS",
    "symbol": "TCS",
    "reason": "India's biggest IT exporter with stable global enterprise revenue.",
    },

    {
    "name": "HDFC Bank",
    "symbol": "HDFCBANK",
    "reason": "Strong retail banking dominance and consistent profit growth.",
    },

    ];


  }

  static List<Map<String, dynamic>> getMutualFunds() {


    return [

    {
    "name": "Parag Parikh Flexi Cap Fund",
    "link": "https://amfiindia.com",
    "reason": "One of India's most consistent flexi-cap mutual funds.",
    },

    {
    "name": "Axis Bluechip Fund",
    "link": "https://amfiindia.com",
    "reason": "Stable large-cap exposure with long-term performance.",
    },

    {
    "name": "Mirae Asset Large Cap Fund",
    "link": "https://amfiindia.com",
    "reason": "Strong diversified equity portfolio.",
    },

    ];


  }

  static List<Map<String, dynamic>> getETFs() {


    return [

    {
    "name": "Nippon India Nifty ETF",
    "symbol": "NIFTYBEES",
    "reason": "Tracks NIFTY 50 with very low expense ratio.",
    },

    {
    "name": "SBI ETF Sensex",
    "symbol": "SETFNIF50",
    "reason": "Diversified exposure to India's top companies.",
    },

    {
    "name": "ICICI Prudential Nifty ETF",
    "symbol": "ICICINIFTY",
    "reason": "Strong liquidity and passive index tracking.",
    },

    ];


  }

  static List<Map<String, dynamic>> getCrypto() {


    return [

    {
    "name": "Bitcoin",
    "symbol": "BTC",
    "reason": "Largest and most secure cryptocurrency with institutional adoption.",
    },

    {
    "name": "Ethereum",
    "symbol": "ETH",
    "reason": "Leading blockchain for decentralized finance and smart contracts.",
    },

    {
    "name": "Solana",
    "symbol": "SOL",
    "reason": "High-speed blockchain used in DeFi and NFT ecosystems.",
    },

    ];


  }

  static List<Map<String, dynamic>> getGold() {


    return [

    {
    "name": "Gold ETF",
    "symbol": "GOLDBEES",
    "reason": "Easy way to invest in gold through stock exchanges.",
    },

    {
    "name": "Sovereign Gold Bonds",
    "symbol": "SGB",
    "reason": "Government-backed gold investment with interest income.",
    },

    {
    "name": "Digital Gold",
    "symbol": "DIGITAL GOLD",
    "reason": "Flexible gold investment through fintech platforms.",
    },

    ];


  }

  static List<Map<String, dynamic>> getREITs() {


    return [

    {
    "name": "Embassy Office Parks REIT",
    "symbol": "EMBASSY",
    "reason": "India's largest REIT with strong rental income.",
    },

    {
    "name": "Mindspace Business Parks REIT",
    "symbol": "MINDSPACE",
    "reason": "Premium office properties in major Indian cities.",
    },

    {
    "name": "Brookfield India REIT",
    "symbol": "BROOKFIELD",
    "reason": "Institutional-grade commercial real estate portfolio.",
    },

    ];


  }

}
