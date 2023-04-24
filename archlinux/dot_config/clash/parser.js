// https://docs.cfw.lbyczf.com/contents/parser.html
// https://github.com/Loyalsoldier/clash-rules

const rule_providers = `
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

  greatfire:
    type: http
    behavior: domain
    url: "https://cdn.jsdelivr.net/gh/Loyalsoldier/clash-rules@release/greatfire.txt"
    path: ./ruleset/greatfire.yaml
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

const rules = `
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

const get_country_code = async (name) => {
  const i = name.search(/\d/);
  if (i < 0) {
    return null;
  }
  return name.slice(0, i).trim();
};

const group_proxies = async (names) => {
  const groups = {};
  for (const name of names) {
    const code = await get_country_code(name);
    if (code) {
      if (!groups[code]) {
        groups[code] = [];
      }
      groups[code].push(name);
    }
  }
  return groups;
};

module.exports.parse = async (
  raw,
  { axios, yaml, notify, console },
  { name, url, interval, selected },
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
      proxies: ["Select Country", "Auto", "Select", "DIRECT"],
    },
    {
      name: "Select",
      type: "select",
      proxies: proxy_names,
    },
    {
      name: "Select Country",
      type: "select",
      proxies: Object.keys(groups).map(
        (country_code) => `${country_code} Auto`,
      ),
    },
    {
      ...url_test,
      name: "Auto",
      proxies: Object.keys(groups).map(
        (country_code) => `${country_code} Auto`,
      ),
    },
    ...Object.keys(groups).map((country_code) => {
      return {
        ...url_test,
        name: `${country_code} Auto`,
        proxies: groups[country_code],
      };
    }),
  ];

  obj.assign(yaml.parse(rule_providers));
  obj.assign(yaml.parse(rules));

  return yaml.stringify(obj);
};
