const fs = require("fs");

if(!fs.existsSync("./out")) fs.mkdirSync("./out");

const egg = JSON.parse(fs.readFileSync("./SCPSL-Egg.json", "utf-8"));

egg.config.files = fs.readFileSync("./configs/files.json", "utf-8");
egg.config.startup = fs.readFileSync("./configs/startup.json", "utf-8");
egg.config.logs = fs.readFileSync("./configs/logs.json", "utf-8");

egg.scripts.installation.script = fs.readFileSync("./install.sh", "utf-8");

fs.writeFileSync("./out/SCPSL-Egg.json", JSON.stringify(egg));