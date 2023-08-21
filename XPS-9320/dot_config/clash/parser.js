// https://docs.cfw.lbyczf.com/contents/parser.html
// https://github.com/Loyalsoldier/clash-rules

const RULE_PROVIDERS = `
rule-providers:
  reject:
    type: http
    behavior: domain
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/reject.txt"
    path: ./ruleset/reject.yaml
    interval: 86400

  icloud:
    type: http
    behavior: domain
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/icloud.txt"
    path: ./ruleset/icloud.yaml
    interval: 86400

  apple:
    type: http
    behavior: domain
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/apple.txt"
    path: ./ruleset/apple.yaml
    interval: 86400

  google:
    type: http
    behavior: domain
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/google.txt"
    path: ./ruleset/google.yaml
    interval: 86400

  proxy:
    type: http
    behavior: domain
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/proxy.txt"
    path: ./ruleset/proxy.yaml
    interval: 86400

  direct:
    type: http
    behavior: domain
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/direct.txt"
    path: ./ruleset/direct.yaml
    interval: 86400

  private:
    type: http
    behavior: domain
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/private.txt"
    path: ./ruleset/private.yaml
    interval: 86400

  gfw:
    type: http
    behavior: domain
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/gfw.txt"
    path: ./ruleset/gfw.yaml
    interval: 86400

  tld-not-cn:
    type: http
    behavior: domain
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/tld-not-cn.txt"
    path: ./ruleset/tld-not-cn.yaml
    interval: 86400

  telegramcidr:
    type: http
    behavior: ipcidr
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/telegramcidr.txt"
    path: ./ruleset/telegramcidr.yaml
    interval: 86400

  cncidr:
    type: http
    behavior: ipcidr
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/cncidr.txt"
    path: ./ruleset/cncidr.yaml
    interval: 86400

  lancidr:
    type: http
    behavior: ipcidr
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/lancidr.txt"
    path: ./ruleset/lancidr.yaml
    interval: 86400

  applications:
    type: http
    behavior: classical
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/applications.txt"
    path: ./ruleset/applications.yaml
    interval: 86400
`;

const RULES = `
rules:
  - RULE-SET,applications,DIRECT
  - DOMAIN,clash.razord.top,DIRECT
  - DOMAIN,yacd.haishan.me,DIRECT
  - RULE-SET,private,DIRECT
  - RULE-SET,reject,REJECT
  - RULE-SET,icloud,DIRECT
  - RULE-SET,apple,DIRECT
  - RULE-SET,google,DIRECT
  - RULE-SET,proxy,PROXY
  - RULE-SET,direct,DIRECT
  - RULE-SET,lancidr,DIRECT
  - RULE-SET,cncidr,DIRECT
  - RULE-SET,telegramcidr,PROXY
  - GEOIP,LAN,DIRECT
  - GEOIP,CN,DIRECT
  - MATCH,PROXY
`;

const COUNTRIES = {
  "🇦🇷 AR 阿根廷": ["🇦🇷", "AR", "阿根廷"],
  "🇦🇺 AU 澳大利亚": ["🇦🇺", "AU", "澳大利亚"],
  "🇨🇦 CA 加拿大": ["🇨🇦", "CA", "加拿大"],
  "🇨🇭 CH 瑞士": ["🇨🇭", "CH", "瑞士"],
  "🇩🇪 DE 德国": ["🇩🇪", "DE", "德国"],
  "🇪🇸 ES 西班牙": ["🇪🇸", "ES", "西班牙"],
  "🇫🇷 FR 法国": ["🇫🇷", "FR", "法国"],
  "🇬🇧 UK 英国": ["🇬🇧", "UK", "英国"],
  "🇭🇰 HK 香港": ["🇭🇰", "HK", "香港"],
  "🇮🇪 IE 爱尔兰": ["🇮🇪", "IE", "爱尔兰"],
  "🇮🇱 IL 以色列": ["🇮🇱", "IL", "以色列"],
  "🇮🇳 IN 印度": ["🇮🇳", "IN", "印度"],
  "🇯🇵 JP 日本": ["🇯🇵", "JP", "日本"],
  "🇰🇷 KR 韩国": ["🇰🇷", "KR", "韩国"],
  "🇳🇱 NL 荷兰": ["🇳🇱", "NL", "荷兰"],
  "🇳🇴 NO 挪威": ["🇳🇴", "NO", "挪威"],
  "🇷🇺 RU 俄罗斯": ["🇷🇺", "RU", "俄罗斯"],
  "🇷🇺 SG 新加坡": ["🇷🇺", "SG", "新加坡"],
  "🇸🇪 SE 瑞典": ["🇸🇪", "SE", "瑞典"],
  "🇹🇷 TR 土耳其": ["🇹🇷", "TR", "土耳其"],
  "🇹🇼 TW 台湾": ["🇹🇼", "TW", "台湾"],
  "🇺🇦 UA 乌克兰": ["🇺🇦", "UA", "乌克兰"],
  "🇺🇸 US 美国": ["🇺🇸", "US", "美国"],
  "🇿🇦 ZA 南非": ["🇿🇦", "ZA", "南非"],
};

const get_country_code = async (proxy_name) => {
  for (const country in COUNTRIES) {
    for (const pattern of COUNTRIES[country]) {
      if (proxy_name.includes(pattern)) {
        return country;
      }
    }
  }
  return "Other";
};

const group_proxies = async (proxy_names) => {
  const groups = {};
  for (const proxy_name of proxy_names) {
    const country = await get_country_code(proxy_name);
    if (!country) continue;
    if (country in groups) {
      groups[country].push(proxy_name);
    } else {
      groups[country] = [proxy_name];
    }
  }
  return groups;
};

module.exports.parse = async (
  raw,
  { axios, yaml, notify, console, homeDir },
  { name, url, interval, selected, mode },
) => {
  const obj = yaml.parse(raw);

  const proxy_names = obj["proxies"].map((proxy) => proxy.name);

  const url_test = {
    type: "url-test",
    url: "http://www.gstatic.com/generate_204",
    interval: 300,
  };

  const groups = await group_proxies(proxy_names);

  obj["proxy-groups"] = [
    {
      name: "PROXY",
      type: "select",
      proxies: ["Select Group", "Auto", "Select Proxy", "DIRECT"],
    },
    {
      name: "Select Group",
      type: "select",
      proxies: Object.keys(groups),
    },
    {
      name: "Select Proxy",
      type: "select",
      proxies: proxy_names,
    },
    {
      ...url_test,
      name: "Auto",
      proxies: Object.keys(groups),
    },
    ...Object.keys(groups).map((group_name) => {
      return {
        ...url_test,
        name: group_name,
        proxies: groups[group_name],
      };
    }),
  ];

  Object.assign(obj, yaml.parse(RULE_PROVIDERS));
  Object.assign(obj, yaml.parse(RULES));

  return yaml.stringify(obj);
};
