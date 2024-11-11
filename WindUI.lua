--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.8) ~  Much Love, Ferib 

]]--

local a;
a = {cache={},load=function(b)
	if not a.cache[b] then
		a.cache[b] = {c=a[b]()};
	end
	return a.cache[b].c;
end};
do
	a.a = function()
		return {Name="Dark",Accent="#181818",Outline="#FFFFFF",Text="#FFFFFF",PlaceholderText="#999999"};
	end;
	a.b = function()
		return {Name="Light",Accent="#FFFFFF",Outline="#000000",Text="#000000",PlaceholderText="#777777"};
	end;
	a.c = function()
		return {Name="Lime",Accent="#ecfccb",Outline="#FFFFFF",Text="#1a2e05",PlaceholderText="#999999"};
	end;
	a.d = function()
		return {Dark=a.load("a"),Light=a.load("b"),Lime=a.load("c")};
	end;
	a.e = function()
		return {assets={["lucide-accessibility"]="rbxassetid://10709751939",["lucide-activity"]="rbxassetid://10709752035",["lucide-air-vent"]="rbxassetid://10709752131",["lucide-airplay"]="rbxassetid://10709752254",["lucide-alarm-check"]="rbxassetid://10709752405",["lucide-alarm-clock"]="rbxassetid://10709752630",["lucide-alarm-clock-off"]="rbxassetid://10709752508",["lucide-alarm-minus"]="rbxassetid://10709752732",["lucide-alarm-plus"]="rbxassetid://10709752825",["lucide-album"]="rbxassetid://10709752906",["lucide-alert-circle"]="rbxassetid://10709752996",["lucide-alert-octagon"]="rbxassetid://10709753064",["lucide-alert-triangle"]="rbxassetid://10709753149",["lucide-align-center"]="rbxassetid://10709753570",["lucide-align-center-horizontal"]="rbxassetid://10709753272",["lucide-align-center-vertical"]="rbxassetid://10709753421",["lucide-align-end-horizontal"]="rbxassetid://10709753692",["lucide-align-end-vertical"]="rbxassetid://10709753808",["lucide-align-horizontal-distribute-center"]="rbxassetid://10747779791",["lucide-align-horizontal-distribute-end"]="rbxassetid://10747784534",["lucide-align-horizontal-distribute-start"]="rbxassetid://10709754118",["lucide-align-horizontal-justify-center"]="rbxassetid://10709754204",["lucide-align-horizontal-justify-end"]="rbxassetid://10709754317",["lucide-align-horizontal-justify-start"]="rbxassetid://10709754436",["lucide-align-horizontal-space-around"]="rbxassetid://10709754590",["lucide-align-horizontal-space-between"]="rbxassetid://10709754749",["lucide-align-justify"]="rbxassetid://10709759610",["lucide-align-left"]="rbxassetid://10709759764",["lucide-align-right"]="rbxassetid://10709759895",["lucide-align-start-horizontal"]="rbxassetid://10709760051",["lucide-align-start-vertical"]="rbxassetid://10709760244",["lucide-align-vertical-distribute-center"]="rbxassetid://10709760351",["lucide-align-vertical-distribute-end"]="rbxassetid://10709760434",["lucide-align-vertical-distribute-start"]="rbxassetid://10709760612",["lucide-align-vertical-justify-center"]="rbxassetid://10709760814",["lucide-align-vertical-justify-end"]="rbxassetid://10709761003",["lucide-align-vertical-justify-start"]="rbxassetid://10709761176",["lucide-align-vertical-space-around"]="rbxassetid://10709761324",["lucide-align-vertical-space-between"]="rbxassetid://10709761434",["lucide-anchor"]="rbxassetid://10709761530",["lucide-angry"]="rbxassetid://10709761629",["lucide-annoyed"]="rbxassetid://10709761722",["lucide-aperture"]="rbxassetid://10709761813",["lucide-apple"]="rbxassetid://10709761889",["lucide-archive"]="rbxassetid://10709762233",["lucide-archive-restore"]="rbxassetid://10709762058",["lucide-armchair"]="rbxassetid://10709762327",["lucide-arrow-big-down"]="rbxassetid://10747796644",["lucide-arrow-big-left"]="rbxassetid://10709762574",["lucide-arrow-big-right"]="rbxassetid://10709762727",["lucide-arrow-big-up"]="rbxassetid://10709762879",["lucide-arrow-down"]="rbxassetid://10709767827",["lucide-arrow-down-circle"]="rbxassetid://10709763034",["lucide-arrow-down-left"]="rbxassetid://10709767656",["lucide-arrow-down-right"]="rbxassetid://10709767750",["lucide-arrow-left"]="rbxassetid://10709768114",["lucide-arrow-left-circle"]="rbxassetid://10709767936",["lucide-arrow-left-right"]="rbxassetid://10709768019",["lucide-arrow-right"]="rbxassetid://10709768347",["lucide-arrow-right-circle"]="rbxassetid://10709768226",["lucide-arrow-up"]="rbxassetid://10709768939",["lucide-arrow-up-circle"]="rbxassetid://10709768432",["lucide-arrow-up-down"]="rbxassetid://10709768538",["lucide-arrow-up-left"]="rbxassetid://10709768661",["lucide-arrow-up-right"]="rbxassetid://10709768787",["lucide-asterisk"]="rbxassetid://10709769095",["lucide-at-sign"]="rbxassetid://10709769286",["lucide-award"]="rbxassetid://10709769406",["lucide-axe"]="rbxassetid://10709769508",["lucide-axis-3d"]="rbxassetid://10709769598",["lucide-baby"]="rbxassetid://10709769732",["lucide-backpack"]="rbxassetid://10709769841",["lucide-baggage-claim"]="rbxassetid://10709769935",["lucide-banana"]="rbxassetid://10709770005",["lucide-banknote"]="rbxassetid://10709770178",["lucide-bar-chart"]="rbxassetid://10709773755",["lucide-bar-chart-2"]="rbxassetid://10709770317",["lucide-bar-chart-3"]="rbxassetid://10709770431",["lucide-bar-chart-4"]="rbxassetid://10709770560",["lucide-bar-chart-horizontal"]="rbxassetid://10709773669",["lucide-barcode"]="rbxassetid://10747360675",["lucide-baseline"]="rbxassetid://10709773863",["lucide-bath"]="rbxassetid://10709773963",["lucide-battery"]="rbxassetid://10709774640",["lucide-battery-charging"]="rbxassetid://10709774068",["lucide-battery-full"]="rbxassetid://10709774206",["lucide-battery-low"]="rbxassetid://10709774370",["lucide-battery-medium"]="rbxassetid://10709774513",["lucide-beaker"]="rbxassetid://10709774756",["lucide-bed"]="rbxassetid://10709775036",["lucide-bed-double"]="rbxassetid://10709774864",["lucide-bed-single"]="rbxassetid://10709774968",["lucide-beer"]="rbxassetid://10709775167",["lucide-bell"]="rbxassetid://10709775704",["lucide-bell-minus"]="rbxassetid://10709775241",["lucide-bell-off"]="rbxassetid://10709775320",["lucide-bell-plus"]="rbxassetid://10709775448",["lucide-bell-ring"]="rbxassetid://10709775560",["lucide-bike"]="rbxassetid://10709775894",["lucide-binary"]="rbxassetid://10709776050",["lucide-bitcoin"]="rbxassetid://10709776126",["lucide-bluetooth"]="rbxassetid://10709776655",["lucide-bluetooth-connected"]="rbxassetid://10709776240",["lucide-bluetooth-off"]="rbxassetid://10709776344",["lucide-bluetooth-searching"]="rbxassetid://10709776501",["lucide-bold"]="rbxassetid://10747813908",["lucide-bomb"]="rbxassetid://10709781460",["lucide-bone"]="rbxassetid://10709781605",["lucide-book"]="rbxassetid://10709781824",["lucide-book-open"]="rbxassetid://10709781717",["lucide-bookmark"]="rbxassetid://10709782154",["lucide-bookmark-minus"]="rbxassetid://10709781919",["lucide-bookmark-plus"]="rbxassetid://10709782044",["lucide-bot"]="rbxassetid://10709782230",["lucide-box"]="rbxassetid://10709782497",["lucide-box-select"]="rbxassetid://10709782342",["lucide-boxes"]="rbxassetid://10709782582",["lucide-briefcase"]="rbxassetid://10709782662",["lucide-brush"]="rbxassetid://10709782758",["lucide-bug"]="rbxassetid://10709782845",["lucide-building"]="rbxassetid://10709783051",["lucide-building-2"]="rbxassetid://10709782939",["lucide-bus"]="rbxassetid://10709783137",["lucide-cake"]="rbxassetid://10709783217",["lucide-calculator"]="rbxassetid://10709783311",["lucide-calendar"]="rbxassetid://10709789505",["lucide-calendar-check"]="rbxassetid://10709783474",["lucide-calendar-check-2"]="rbxassetid://10709783392",["lucide-calendar-clock"]="rbxassetid://10709783577",["lucide-calendar-days"]="rbxassetid://10709783673",["lucide-calendar-heart"]="rbxassetid://10709783835",["lucide-calendar-minus"]="rbxassetid://10709783959",["lucide-calendar-off"]="rbxassetid://10709788784",["lucide-calendar-plus"]="rbxassetid://10709788937",["lucide-calendar-range"]="rbxassetid://10709789053",["lucide-calendar-search"]="rbxassetid://10709789200",["lucide-calendar-x"]="rbxassetid://10709789407",["lucide-calendar-x-2"]="rbxassetid://10709789329",["lucide-camera"]="rbxassetid://10709789686",["lucide-camera-off"]="rbxassetid://10747822677",["lucide-car"]="rbxassetid://10709789810",["lucide-carrot"]="rbxassetid://10709789960",["lucide-cast"]="rbxassetid://10709790097",["lucide-charge"]="rbxassetid://10709790202",["lucide-check"]="rbxassetid://10709790644",["lucide-check-circle"]="rbxassetid://10709790387",["lucide-check-circle-2"]="rbxassetid://10709790298",["lucide-check-square"]="rbxassetid://10709790537",["lucide-chef-hat"]="rbxassetid://10709790757",["lucide-cherry"]="rbxassetid://10709790875",["lucide-chevron-down"]="rbxassetid://10709790948",["lucide-chevron-first"]="rbxassetid://10709791015",["lucide-chevron-last"]="rbxassetid://10709791130",["lucide-chevron-left"]="rbxassetid://10709791281",["lucide-chevron-right"]="rbxassetid://10709791437",["lucide-chevron-up"]="rbxassetid://10709791523",["lucide-chevrons-down"]="rbxassetid://10709796864",["lucide-chevrons-down-up"]="rbxassetid://10709791632",["lucide-chevrons-left"]="rbxassetid://10709797151",["lucide-chevrons-left-right"]="rbxassetid://10709797006",["lucide-chevrons-right"]="rbxassetid://10709797382",["lucide-chevrons-right-left"]="rbxassetid://10709797274",["lucide-chevrons-up"]="rbxassetid://10709797622",["lucide-chevrons-up-down"]="rbxassetid://10709797508",["lucide-chrome"]="rbxassetid://10709797725",["lucide-circle"]="rbxassetid://10709798174",["lucide-circle-dot"]="rbxassetid://10709797837",["lucide-circle-ellipsis"]="rbxassetid://10709797985",["lucide-circle-slashed"]="rbxassetid://10709798100",["lucide-citrus"]="rbxassetid://10709798276",["lucide-clapperboard"]="rbxassetid://10709798350",["lucide-clipboard"]="rbxassetid://10709799288",["lucide-clipboard-check"]="rbxassetid://10709798443",["lucide-clipboard-copy"]="rbxassetid://10709798574",["lucide-clipboard-edit"]="rbxassetid://10709798682",["lucide-clipboard-list"]="rbxassetid://10709798792",["lucide-clipboard-signature"]="rbxassetid://10709798890",["lucide-clipboard-type"]="rbxassetid://10709798999",["lucide-clipboard-x"]="rbxassetid://10709799124",["lucide-clock"]="rbxassetid://10709805144",["lucide-clock-1"]="rbxassetid://10709799535",["lucide-clock-10"]="rbxassetid://10709799718",["lucide-clock-11"]="rbxassetid://10709799818",["lucide-clock-12"]="rbxassetid://10709799962",["lucide-clock-2"]="rbxassetid://10709803876",["lucide-clock-3"]="rbxassetid://10709803989",["lucide-clock-4"]="rbxassetid://10709804164",["lucide-clock-5"]="rbxassetid://10709804291",["lucide-clock-6"]="rbxassetid://10709804435",["lucide-clock-7"]="rbxassetid://10709804599",["lucide-clock-8"]="rbxassetid://10709804784",["lucide-clock-9"]="rbxassetid://10709804996",["lucide-cloud"]="rbxassetid://10709806740",["lucide-cloud-cog"]="rbxassetid://10709805262",["lucide-cloud-drizzle"]="rbxassetid://10709805371",["lucide-cloud-fog"]="rbxassetid://10709805477",["lucide-cloud-hail"]="rbxassetid://10709805596",["lucide-cloud-lightning"]="rbxassetid://10709805727",["lucide-cloud-moon"]="rbxassetid://10709805942",["lucide-cloud-moon-rain"]="rbxassetid://10709805838",["lucide-cloud-off"]="rbxassetid://10709806060",["lucide-cloud-rain"]="rbxassetid://10709806277",["lucide-cloud-rain-wind"]="rbxassetid://10709806166",["lucide-cloud-snow"]="rbxassetid://10709806374",["lucide-cloud-sun"]="rbxassetid://10709806631",["lucide-cloud-sun-rain"]="rbxassetid://10709806475",["lucide-cloudy"]="rbxassetid://10709806859",["lucide-clover"]="rbxassetid://10709806995",["lucide-code"]="rbxassetid://10709810463",["lucide-code-2"]="rbxassetid://10709807111",["lucide-codepen"]="rbxassetid://10709810534",["lucide-codesandbox"]="rbxassetid://10709810676",["lucide-coffee"]="rbxassetid://10709810814",["lucide-cog"]="rbxassetid://10709810948",["lucide-coins"]="rbxassetid://10709811110",["lucide-columns"]="rbxassetid://10709811261",["lucide-command"]="rbxassetid://10709811365",["lucide-compass"]="rbxassetid://10709811445",["lucide-component"]="rbxassetid://10709811595",["lucide-concierge-bell"]="rbxassetid://10709811706",["lucide-connection"]="rbxassetid://10747361219",["lucide-contact"]="rbxassetid://10709811834",["lucide-contrast"]="rbxassetid://10709811939",["lucide-cookie"]="rbxassetid://10709812067",["lucide-copy"]="rbxassetid://10709812159",["lucide-copyleft"]="rbxassetid://10709812251",["lucide-copyright"]="rbxassetid://10709812311",["lucide-corner-down-left"]="rbxassetid://10709812396",["lucide-corner-down-right"]="rbxassetid://10709812485",["lucide-corner-left-down"]="rbxassetid://10709812632",["lucide-corner-left-up"]="rbxassetid://10709812784",["lucide-corner-right-down"]="rbxassetid://10709812939",["lucide-corner-right-up"]="rbxassetid://10709813094",["lucide-corner-up-left"]="rbxassetid://10709813185",["lucide-corner-up-right"]="rbxassetid://10709813281",["lucide-cpu"]="rbxassetid://10709813383",["lucide-croissant"]="rbxassetid://10709818125",["lucide-crop"]="rbxassetid://10709818245",["lucide-cross"]="rbxassetid://10709818399",["lucide-crosshair"]="rbxassetid://10709818534",["lucide-crown"]="rbxassetid://10709818626",["lucide-cup-soda"]="rbxassetid://10709818763",["lucide-curly-braces"]="rbxassetid://10709818847",["lucide-currency"]="rbxassetid://10709818931",["lucide-database"]="rbxassetid://10709818996",["lucide-delete"]="rbxassetid://10709819059",["lucide-diamond"]="rbxassetid://10709819149",["lucide-dice-1"]="rbxassetid://10709819266",["lucide-dice-2"]="rbxassetid://10709819361",["lucide-dice-3"]="rbxassetid://10709819508",["lucide-dice-4"]="rbxassetid://10709819670",["lucide-dice-5"]="rbxassetid://10709819801",["lucide-dice-6"]="rbxassetid://10709819896",["lucide-dices"]="rbxassetid://10723343321",["lucide-diff"]="rbxassetid://10723343416",["lucide-disc"]="rbxassetid://10723343537",["lucide-divide"]="rbxassetid://10723343805",["lucide-divide-circle"]="rbxassetid://10723343636",["lucide-divide-square"]="rbxassetid://10723343737",["lucide-dollar-sign"]="rbxassetid://10723343958",["lucide-download"]="rbxassetid://10723344270",["lucide-download-cloud"]="rbxassetid://10723344088",["lucide-droplet"]="rbxassetid://10723344432",["lucide-droplets"]="rbxassetid://10734883356",["lucide-drumstick"]="rbxassetid://10723344737",["lucide-edit"]="rbxassetid://10734883598",["lucide-edit-2"]="rbxassetid://10723344885",["lucide-edit-3"]="rbxassetid://10723345088",["lucide-egg"]="rbxassetid://10723345518",["lucide-egg-fried"]="rbxassetid://10723345347",["lucide-electricity"]="rbxassetid://10723345749",["lucide-electricity-off"]="rbxassetid://10723345643",["lucide-equal"]="rbxassetid://10723345990",["lucide-equal-not"]="rbxassetid://10723345866",["lucide-eraser"]="rbxassetid://10723346158",["lucide-euro"]="rbxassetid://10723346372",["lucide-expand"]="rbxassetid://10723346553",["lucide-external-link"]="rbxassetid://10723346684",["lucide-eye"]="rbxassetid://10723346959",["lucide-eye-off"]="rbxassetid://10723346871",["lucide-factory"]="rbxassetid://10723347051",["lucide-fan"]="rbxassetid://10723354359",["lucide-fast-forward"]="rbxassetid://10723354521",["lucide-feather"]="rbxassetid://10723354671",["lucide-figma"]="rbxassetid://10723354801",["lucide-file"]="rbxassetid://10723374641",["lucide-file-archive"]="rbxassetid://10723354921",["lucide-file-audio"]="rbxassetid://10723355148",["lucide-file-audio-2"]="rbxassetid://10723355026",["lucide-file-axis-3d"]="rbxassetid://10723355272",["lucide-file-badge"]="rbxassetid://10723355622",["lucide-file-badge-2"]="rbxassetid://10723355451",["lucide-file-bar-chart"]="rbxassetid://10723355887",["lucide-file-bar-chart-2"]="rbxassetid://10723355746",["lucide-file-box"]="rbxassetid://10723355989",["lucide-file-check"]="rbxassetid://10723356210",["lucide-file-check-2"]="rbxassetid://10723356100",["lucide-file-clock"]="rbxassetid://10723356329",["lucide-file-code"]="rbxassetid://10723356507",["lucide-file-cog"]="rbxassetid://10723356830",["lucide-file-cog-2"]="rbxassetid://10723356676",["lucide-file-diff"]="rbxassetid://10723357039",["lucide-file-digit"]="rbxassetid://10723357151",["lucide-file-down"]="rbxassetid://10723357322",["lucide-file-edit"]="rbxassetid://10723357495",["lucide-file-heart"]="rbxassetid://10723357637",["lucide-file-image"]="rbxassetid://10723357790",["lucide-file-input"]="rbxassetid://10723357933",["lucide-file-json"]="rbxassetid://10723364435",["lucide-file-json-2"]="rbxassetid://10723364361",["lucide-file-key"]="rbxassetid://10723364605",["lucide-file-key-2"]="rbxassetid://10723364515",["lucide-file-line-chart"]="rbxassetid://10723364725",["lucide-file-lock"]="rbxassetid://10723364957",["lucide-file-lock-2"]="rbxassetid://10723364861",["lucide-file-minus"]="rbxassetid://10723365254",["lucide-file-minus-2"]="rbxassetid://10723365086",["lucide-file-output"]="rbxassetid://10723365457",["lucide-file-pie-chart"]="rbxassetid://10723365598",["lucide-file-plus"]="rbxassetid://10723365877",["lucide-file-plus-2"]="rbxassetid://10723365766",["lucide-file-question"]="rbxassetid://10723365987",["lucide-file-scan"]="rbxassetid://10723366167",["lucide-file-search"]="rbxassetid://10723366550",["lucide-file-search-2"]="rbxassetid://10723366340",["lucide-file-signature"]="rbxassetid://10723366741",["lucide-file-spreadsheet"]="rbxassetid://10723366962",["lucide-file-symlink"]="rbxassetid://10723367098",["lucide-file-terminal"]="rbxassetid://10723367244",["lucide-file-text"]="rbxassetid://10723367380",["lucide-file-type"]="rbxassetid://10723367606",["lucide-file-type-2"]="rbxassetid://10723367509",["lucide-file-up"]="rbxassetid://10723367734",["lucide-file-video"]="rbxassetid://10723373884",["lucide-file-video-2"]="rbxassetid://10723367834",["lucide-file-volume"]="rbxassetid://10723374172",["lucide-file-volume-2"]="rbxassetid://10723374030",["lucide-file-warning"]="rbxassetid://10723374276",["lucide-file-x"]="rbxassetid://10723374544",["lucide-file-x-2"]="rbxassetid://10723374378",["lucide-files"]="rbxassetid://10723374759",["lucide-film"]="rbxassetid://10723374981",["lucide-filter"]="rbxassetid://10723375128",["lucide-fingerprint"]="rbxassetid://10723375250",["lucide-flag"]="rbxassetid://10723375890",["lucide-flag-off"]="rbxassetid://10723375443",["lucide-flag-triangle-left"]="rbxassetid://10723375608",["lucide-flag-triangle-right"]="rbxassetid://10723375727",["lucide-flame"]="rbxassetid://10723376114",["lucide-flashlight"]="rbxassetid://10723376471",["lucide-flashlight-off"]="rbxassetid://10723376365",["lucide-flask-conical"]="rbxassetid://10734883986",["lucide-flask-round"]="rbxassetid://10723376614",["lucide-flip-horizontal"]="rbxassetid://10723376884",["lucide-flip-horizontal-2"]="rbxassetid://10723376745",["lucide-flip-vertical"]="rbxassetid://10723377138",["lucide-flip-vertical-2"]="rbxassetid://10723377026",["lucide-flower"]="rbxassetid://10747830374",["lucide-flower-2"]="rbxassetid://10723377305",["lucide-focus"]="rbxassetid://10723377537",["lucide-folder"]="rbxassetid://10723387563",["lucide-folder-archive"]="rbxassetid://10723384478",["lucide-folder-check"]="rbxassetid://10723384605",["lucide-folder-clock"]="rbxassetid://10723384731",["lucide-folder-closed"]="rbxassetid://10723384893",["lucide-folder-cog"]="rbxassetid://10723385213",["lucide-folder-cog-2"]="rbxassetid://10723385036",["lucide-folder-down"]="rbxassetid://10723385338",["lucide-folder-edit"]="rbxassetid://10723385445",["lucide-folder-heart"]="rbxassetid://10723385545",["lucide-folder-input"]="rbxassetid://10723385721",["lucide-folder-key"]="rbxassetid://10723385848",["lucide-folder-lock"]="rbxassetid://10723386005",["lucide-folder-minus"]="rbxassetid://10723386127",["lucide-folder-open"]="rbxassetid://10723386277",["lucide-folder-output"]="rbxassetid://10723386386",["lucide-folder-plus"]="rbxassetid://10723386531",["lucide-folder-search"]="rbxassetid://10723386787",["lucide-folder-search-2"]="rbxassetid://10723386674",["lucide-folder-symlink"]="rbxassetid://10723386930",["lucide-folder-tree"]="rbxassetid://10723387085",["lucide-folder-up"]="rbxassetid://10723387265",["lucide-folder-x"]="rbxassetid://10723387448",["lucide-folders"]="rbxassetid://10723387721",["lucide-form-input"]="rbxassetid://10723387841",["lucide-forward"]="rbxassetid://10723388016",["lucide-frame"]="rbxassetid://10723394389",["lucide-framer"]="rbxassetid://10723394565",["lucide-frown"]="rbxassetid://10723394681",["lucide-fuel"]="rbxassetid://10723394846",["lucide-function-square"]="rbxassetid://10723395041",["lucide-gamepad"]="rbxassetid://10723395457",["lucide-gamepad-2"]="rbxassetid://10723395215",["lucide-gauge"]="rbxassetid://10723395708",["lucide-gavel"]="rbxassetid://10723395896",["lucide-gem"]="rbxassetid://10723396000",["lucide-ghost"]="rbxassetid://10723396107",["lucide-gift"]="rbxassetid://10723396402",["lucide-gift-card"]="rbxassetid://10723396225",["lucide-git-branch"]="rbxassetid://10723396676",["lucide-git-branch-plus"]="rbxassetid://10723396542",["lucide-git-commit"]="rbxassetid://10723396812",["lucide-git-compare"]="rbxassetid://10723396954",["lucide-git-fork"]="rbxassetid://10723397049",["lucide-git-merge"]="rbxassetid://10723397165",["lucide-git-pull-request"]="rbxassetid://10723397431",["lucide-git-pull-request-closed"]="rbxassetid://10723397268",["lucide-git-pull-request-draft"]="rbxassetid://10734884302",["lucide-glass"]="rbxassetid://10723397788",["lucide-glass-2"]="rbxassetid://10723397529",["lucide-glass-water"]="rbxassetid://10723397678",["lucide-glasses"]="rbxassetid://10723397895",["lucide-globe"]="rbxassetid://10723404337",["lucide-globe-2"]="rbxassetid://10723398002",["lucide-grab"]="rbxassetid://10723404472",["lucide-graduation-cap"]="rbxassetid://10723404691",["lucide-grape"]="rbxassetid://10723404822",["lucide-grid"]="rbxassetid://10723404936",["lucide-grip-horizontal"]="rbxassetid://10723405089",["lucide-grip-vertical"]="rbxassetid://10723405236",["lucide-hammer"]="rbxassetid://10723405360",["lucide-hand"]="rbxassetid://10723405649",["lucide-hand-metal"]="rbxassetid://10723405508",["lucide-hard-drive"]="rbxassetid://10723405749",["lucide-hard-hat"]="rbxassetid://10723405859",["lucide-hash"]="rbxassetid://10723405975",["lucide-haze"]="rbxassetid://10723406078",["lucide-headphones"]="rbxassetid://10723406165",["lucide-heart"]="rbxassetid://10723406885",["lucide-heart-crack"]="rbxassetid://10723406299",["lucide-heart-handshake"]="rbxassetid://10723406480",["lucide-heart-off"]="rbxassetid://10723406662",["lucide-heart-pulse"]="rbxassetid://10723406795",["lucide-help-circle"]="rbxassetid://10723406988",["lucide-hexagon"]="rbxassetid://10723407092",["lucide-highlighter"]="rbxassetid://10723407192",["lucide-history"]="rbxassetid://10723407335",["lucide-home"]="rbxassetid://10723407389",["lucide-hourglass"]="rbxassetid://10723407498",["lucide-ice-cream"]="rbxassetid://10723414308",["lucide-image"]="rbxassetid://10723415040",["lucide-image-minus"]="rbxassetid://10723414487",["lucide-image-off"]="rbxassetid://10723414677",["lucide-image-plus"]="rbxassetid://10723414827",["lucide-import"]="rbxassetid://10723415205",["lucide-inbox"]="rbxassetid://10723415335",["lucide-indent"]="rbxassetid://10723415494",["lucide-indian-rupee"]="rbxassetid://10723415642",["lucide-infinity"]="rbxassetid://10723415766",["lucide-info"]="rbxassetid://10723415903",["lucide-inspect"]="rbxassetid://10723416057",["lucide-italic"]="rbxassetid://10723416195",["lucide-japanese-yen"]="rbxassetid://10723416363",["lucide-joystick"]="rbxassetid://10723416527",["lucide-key"]="rbxassetid://10723416652",["lucide-keyboard"]="rbxassetid://10723416765",["lucide-lamp"]="rbxassetid://10723417513",["lucide-lamp-ceiling"]="rbxassetid://10723416922",["lucide-lamp-desk"]="rbxassetid://10723417016",["lucide-lamp-floor"]="rbxassetid://10723417131",["lucide-lamp-wall-down"]="rbxassetid://10723417240",["lucide-lamp-wall-up"]="rbxassetid://10723417356",["lucide-landmark"]="rbxassetid://10723417608",["lucide-languages"]="rbxassetid://10723417703",["lucide-laptop"]="rbxassetid://10723423881",["lucide-laptop-2"]="rbxassetid://10723417797",["lucide-lasso"]="rbxassetid://10723424235",["lucide-lasso-select"]="rbxassetid://10723424058",["lucide-laugh"]="rbxassetid://10723424372",["lucide-layers"]="rbxassetid://10723424505",["lucide-layout"]="rbxassetid://10723425376",["lucide-layout-dashboard"]="rbxassetid://10723424646",["lucide-layout-grid"]="rbxassetid://10723424838",["lucide-layout-list"]="rbxassetid://10723424963",["lucide-layout-template"]="rbxassetid://10723425187",["lucide-leaf"]="rbxassetid://10723425539",["lucide-library"]="rbxassetid://10723425615",["lucide-life-buoy"]="rbxassetid://10723425685",["lucide-lightbulb"]="rbxassetid://10723425852",["lucide-lightbulb-off"]="rbxassetid://10723425762",["lucide-line-chart"]="rbxassetid://10723426393",["lucide-link"]="rbxassetid://10723426722",["lucide-link-2"]="rbxassetid://10723426595",["lucide-link-2-off"]="rbxassetid://10723426513",["lucide-list"]="rbxassetid://10723433811",["lucide-list-checks"]="rbxassetid://10734884548",["lucide-list-end"]="rbxassetid://10723426886",["lucide-list-minus"]="rbxassetid://10723426986",["lucide-list-music"]="rbxassetid://10723427081",["lucide-list-ordered"]="rbxassetid://10723427199",["lucide-list-plus"]="rbxassetid://10723427334",["lucide-list-start"]="rbxassetid://10723427494",["lucide-list-video"]="rbxassetid://10723427619",["lucide-list-x"]="rbxassetid://10723433655",["lucide-loader"]="rbxassetid://10723434070",["lucide-loader-2"]="rbxassetid://10723433935",["lucide-locate"]="rbxassetid://10723434557",["lucide-locate-fixed"]="rbxassetid://10723434236",["lucide-locate-off"]="rbxassetid://10723434379",["lucide-lock"]="rbxassetid://10723434711",["lucide-log-in"]="rbxassetid://10723434830",["lucide-log-out"]="rbxassetid://10723434906",["lucide-luggage"]="rbxassetid://10723434993",["lucide-magnet"]="rbxassetid://10723435069",["lucide-mail"]="rbxassetid://10734885430",["lucide-mail-check"]="rbxassetid://10723435182",["lucide-mail-minus"]="rbxassetid://10723435261",["lucide-mail-open"]="rbxassetid://10723435342",["lucide-mail-plus"]="rbxassetid://10723435443",["lucide-mail-question"]="rbxassetid://10723435515",["lucide-mail-search"]="rbxassetid://10734884739",["lucide-mail-warning"]="rbxassetid://10734885015",["lucide-mail-x"]="rbxassetid://10734885247",["lucide-mails"]="rbxassetid://10734885614",["lucide-map"]="rbxassetid://10734886202",["lucide-map-pin"]="rbxassetid://10734886004",["lucide-map-pin-off"]="rbxassetid://10734885803",["lucide-maximize"]="rbxassetid://10734886735",["lucide-maximize-2"]="rbxassetid://10734886496",["lucide-medal"]="rbxassetid://10734887072",["lucide-megaphone"]="rbxassetid://10734887454",["lucide-megaphone-off"]="rbxassetid://10734887311",["lucide-meh"]="rbxassetid://10734887603",["lucide-menu"]="rbxassetid://10734887784",["lucide-message-circle"]="rbxassetid://10734888000",["lucide-message-square"]="rbxassetid://10734888228",["lucide-mic"]="rbxassetid://10734888864",["lucide-mic-2"]="rbxassetid://10734888430",["lucide-mic-off"]="rbxassetid://10734888646",["lucide-microscope"]="rbxassetid://10734889106",["lucide-microwave"]="rbxassetid://10734895076",["lucide-milestone"]="rbxassetid://10734895310",["lucide-minimize"]="rbxassetid://10734895698",["lucide-minimize-2"]="rbxassetid://10734895530",["lucide-minus"]="rbxassetid://10734896206",["lucide-minus-circle"]="rbxassetid://10734895856",["lucide-minus-square"]="rbxassetid://10734896029",["lucide-monitor"]="rbxassetid://10734896881",["lucide-monitor-off"]="rbxassetid://10734896360",["lucide-monitor-speaker"]="rbxassetid://10734896512",["lucide-moon"]="rbxassetid://10734897102",["lucide-more-horizontal"]="rbxassetid://10734897250",["lucide-more-vertical"]="rbxassetid://10734897387",["lucide-mountain"]="rbxassetid://10734897956",["lucide-mountain-snow"]="rbxassetid://10734897665",["lucide-mouse"]="rbxassetid://10734898592",["lucide-mouse-pointer"]="rbxassetid://10734898476",["lucide-mouse-pointer-2"]="rbxassetid://10734898194",["lucide-mouse-pointer-click"]="rbxassetid://10734898355",["lucide-move"]="rbxassetid://10734900011",["lucide-move-3d"]="rbxassetid://10734898756",["lucide-move-diagonal"]="rbxassetid://10734899164",["lucide-move-diagonal-2"]="rbxassetid://10734898934",["lucide-move-horizontal"]="rbxassetid://10734899414",["lucide-move-vertical"]="rbxassetid://10734899821",["lucide-music"]="rbxassetid://10734905958",["lucide-music-2"]="rbxassetid://10734900215",["lucide-music-3"]="rbxassetid://10734905665",["lucide-music-4"]="rbxassetid://10734905823",["lucide-navigation"]="rbxassetid://10734906744",["lucide-navigation-2"]="rbxassetid://10734906332",["lucide-navigation-2-off"]="rbxassetid://10734906144",["lucide-navigation-off"]="rbxassetid://10734906580",["lucide-network"]="rbxassetid://10734906975",["lucide-newspaper"]="rbxassetid://10734907168",["lucide-octagon"]="rbxassetid://10734907361",["lucide-option"]="rbxassetid://10734907649",["lucide-outdent"]="rbxassetid://10734907933",["lucide-package"]="rbxassetid://10734909540",["lucide-package-2"]="rbxassetid://10734908151",["lucide-package-check"]="rbxassetid://10734908384",["lucide-package-minus"]="rbxassetid://10734908626",["lucide-package-open"]="rbxassetid://10734908793",["lucide-package-plus"]="rbxassetid://10734909016",["lucide-package-search"]="rbxassetid://10734909196",["lucide-package-x"]="rbxassetid://10734909375",["lucide-paint-bucket"]="rbxassetid://10734909847",["lucide-paintbrush"]="rbxassetid://10734910187",["lucide-paintbrush-2"]="rbxassetid://10734910030",["lucide-palette"]="rbxassetid://10734910430",["lucide-palmtree"]="rbxassetid://10734910680",["lucide-paperclip"]="rbxassetid://10734910927",["lucide-party-popper"]="rbxassetid://10734918735",["lucide-pause"]="rbxassetid://10734919336",["lucide-pause-circle"]="rbxassetid://10735024209",["lucide-pause-octagon"]="rbxassetid://10734919143",["lucide-pen-tool"]="rbxassetid://10734919503",["lucide-pencil"]="rbxassetid://10734919691",["lucide-percent"]="rbxassetid://10734919919",["lucide-person-standing"]="rbxassetid://10734920149",["lucide-phone"]="rbxassetid://10734921524",["lucide-phone-call"]="rbxassetid://10734920305",["lucide-phone-forwarded"]="rbxassetid://10734920508",["lucide-phone-incoming"]="rbxassetid://10734920694",["lucide-phone-missed"]="rbxassetid://10734920845",["lucide-phone-off"]="rbxassetid://10734921077",["lucide-phone-outgoing"]="rbxassetid://10734921288",["lucide-pie-chart"]="rbxassetid://10734921727",["lucide-piggy-bank"]="rbxassetid://10734921935",["lucide-pin"]="rbxassetid://10734922324",["lucide-pin-off"]="rbxassetid://10734922180",["lucide-pipette"]="rbxassetid://10734922497",["lucide-pizza"]="rbxassetid://10734922774",["lucide-plane"]="rbxassetid://10734922971",["lucide-play"]="rbxassetid://10734923549",["lucide-play-circle"]="rbxassetid://10734923214",["lucide-plus"]="rbxassetid://10734924532",["lucide-plus-circle"]="rbxassetid://10734923868",["lucide-plus-square"]="rbxassetid://10734924219",["lucide-podcast"]="rbxassetid://10734929553",["lucide-pointer"]="rbxassetid://10734929723",["lucide-pound-sterling"]="rbxassetid://10734929981",["lucide-power"]="rbxassetid://10734930466",["lucide-power-off"]="rbxassetid://10734930257",["lucide-printer"]="rbxassetid://10734930632",["lucide-puzzle"]="rbxassetid://10734930886",["lucide-quote"]="rbxassetid://10734931234",["lucide-radio"]="rbxassetid://10734931596",["lucide-radio-receiver"]="rbxassetid://10734931402",["lucide-rectangle-horizontal"]="rbxassetid://10734931777",["lucide-rectangle-vertical"]="rbxassetid://10734932081",["lucide-recycle"]="rbxassetid://10734932295",["lucide-redo"]="rbxassetid://10734932822",["lucide-redo-2"]="rbxassetid://10734932586",["lucide-refresh-ccw"]="rbxassetid://10734933056",["lucide-refresh-cw"]="rbxassetid://10734933222",["lucide-refrigerator"]="rbxassetid://10734933465",["lucide-regex"]="rbxassetid://10734933655",["lucide-repeat"]="rbxassetid://10734933966",["lucide-repeat-1"]="rbxassetid://10734933826",["lucide-reply"]="rbxassetid://10734934252",["lucide-reply-all"]="rbxassetid://10734934132",["lucide-rewind"]="rbxassetid://10734934347",["lucide-rocket"]="rbxassetid://10734934585",["lucide-rocking-chair"]="rbxassetid://10734939942",["lucide-rotate-3d"]="rbxassetid://10734940107",["lucide-rotate-ccw"]="rbxassetid://10734940376",["lucide-rotate-cw"]="rbxassetid://10734940654",["lucide-rss"]="rbxassetid://10734940825",["lucide-ruler"]="rbxassetid://10734941018",["lucide-russian-ruble"]="rbxassetid://10734941199",["lucide-sailboat"]="rbxassetid://10734941354",["lucide-save"]="rbxassetid://10734941499",["lucide-scale"]="rbxassetid://10734941912",["lucide-scale-3d"]="rbxassetid://10734941739",["lucide-scaling"]="rbxassetid://10734942072",["lucide-scan"]="rbxassetid://10734942565",["lucide-scan-face"]="rbxassetid://10734942198",["lucide-scan-line"]="rbxassetid://10734942351",["lucide-scissors"]="rbxassetid://10734942778",["lucide-screen-share"]="rbxassetid://10734943193",["lucide-screen-share-off"]="rbxassetid://10734942967",["lucide-scroll"]="rbxassetid://10734943448",["lucide-search"]="rbxassetid://10734943674",["lucide-send"]="rbxassetid://10734943902",["lucide-separator-horizontal"]="rbxassetid://10734944115",["lucide-separator-vertical"]="rbxassetid://10734944326",["lucide-server"]="rbxassetid://10734949856",["lucide-server-cog"]="rbxassetid://10734944444",["lucide-server-crash"]="rbxassetid://10734944554",["lucide-server-off"]="rbxassetid://10734944668",["lucide-settings"]="rbxassetid://10734950309",["lucide-settings-2"]="rbxassetid://10734950020",["lucide-share"]="rbxassetid://10734950813",["lucide-share-2"]="rbxassetid://10734950553",["lucide-sheet"]="rbxassetid://10734951038",["lucide-shield"]="rbxassetid://10734951847",["lucide-shield-alert"]="rbxassetid://10734951173",["lucide-shield-check"]="rbxassetid://10734951367",["lucide-shield-close"]="rbxassetid://10734951535",["lucide-shield-off"]="rbxassetid://10734951684",["lucide-shirt"]="rbxassetid://10734952036",["lucide-shopping-bag"]="rbxassetid://10734952273",["lucide-shopping-cart"]="rbxassetid://10734952479",["lucide-shovel"]="rbxassetid://10734952773",["lucide-shower-head"]="rbxassetid://10734952942",["lucide-shrink"]="rbxassetid://10734953073",["lucide-shrub"]="rbxassetid://10734953241",["lucide-shuffle"]="rbxassetid://10734953451",["lucide-sidebar"]="rbxassetid://10734954301",["lucide-sidebar-close"]="rbxassetid://10734953715",["lucide-sidebar-open"]="rbxassetid://10734954000",["lucide-sigma"]="rbxassetid://10734954538",["lucide-signal"]="rbxassetid://10734961133",["lucide-signal-high"]="rbxassetid://10734954807",["lucide-signal-low"]="rbxassetid://10734955080",["lucide-signal-medium"]="rbxassetid://10734955336",["lucide-signal-zero"]="rbxassetid://10734960878",["lucide-siren"]="rbxassetid://10734961284",["lucide-skip-back"]="rbxassetid://10734961526",["lucide-skip-forward"]="rbxassetid://10734961809",["lucide-skull"]="rbxassetid://10734962068",["lucide-slack"]="rbxassetid://10734962339",["lucide-slash"]="rbxassetid://10734962600",["lucide-slice"]="rbxassetid://10734963024",["lucide-sliders"]="rbxassetid://10734963400",["lucide-sliders-horizontal"]="rbxassetid://10734963191",["lucide-smartphone"]="rbxassetid://10734963940",["lucide-smartphone-charging"]="rbxassetid://10734963671",["lucide-smile"]="rbxassetid://10734964441",["lucide-smile-plus"]="rbxassetid://10734964188",["lucide-snowflake"]="rbxassetid://10734964600",["lucide-sofa"]="rbxassetid://10734964852",["lucide-sort-asc"]="rbxassetid://10734965115",["lucide-sort-desc"]="rbxassetid://10734965287",["lucide-speaker"]="rbxassetid://10734965419",["lucide-sprout"]="rbxassetid://10734965572",["lucide-square"]="rbxassetid://10734965702",["lucide-star"]="rbxassetid://10734966248",["lucide-star-half"]="rbxassetid://10734965897",["lucide-star-off"]="rbxassetid://10734966097",["lucide-stethoscope"]="rbxassetid://10734966384",["lucide-sticker"]="rbxassetid://10734972234",["lucide-sticky-note"]="rbxassetid://10734972463",["lucide-stop-circle"]="rbxassetid://10734972621",["lucide-stretch-horizontal"]="rbxassetid://10734972862",["lucide-stretch-vertical"]="rbxassetid://10734973130",["lucide-strikethrough"]="rbxassetid://10734973290",["lucide-subscript"]="rbxassetid://10734973457",["lucide-sun"]="rbxassetid://10734974297",["lucide-sun-dim"]="rbxassetid://10734973645",["lucide-sun-medium"]="rbxassetid://10734973778",["lucide-sun-moon"]="rbxassetid://10734973999",["lucide-sun-snow"]="rbxassetid://10734974130",["lucide-sunrise"]="rbxassetid://10734974522",["lucide-sunset"]="rbxassetid://10734974689",["lucide-superscript"]="rbxassetid://10734974850",["lucide-swiss-franc"]="rbxassetid://10734975024",["lucide-switch-camera"]="rbxassetid://10734975214",["lucide-sword"]="rbxassetid://10734975486",["lucide-swords"]="rbxassetid://10734975692",["lucide-syringe"]="rbxassetid://10734975932",["lucide-table"]="rbxassetid://10734976230",["lucide-table-2"]="rbxassetid://10734976097",["lucide-tablet"]="rbxassetid://10734976394",["lucide-tag"]="rbxassetid://10734976528",["lucide-tags"]="rbxassetid://10734976739",["lucide-target"]="rbxassetid://10734977012",["lucide-tent"]="rbxassetid://10734981750",["lucide-terminal"]="rbxassetid://10734982144",["lucide-terminal-square"]="rbxassetid://10734981995",["lucide-text-cursor"]="rbxassetid://10734982395",["lucide-text-cursor-input"]="rbxassetid://10734982297",["lucide-thermometer"]="rbxassetid://10734983134",["lucide-thermometer-snowflake"]="rbxassetid://10734982571",["lucide-thermometer-sun"]="rbxassetid://10734982771",["lucide-thumbs-down"]="rbxassetid://10734983359",["lucide-thumbs-up"]="rbxassetid://10734983629",["lucide-ticket"]="rbxassetid://10734983868",["lucide-timer"]="rbxassetid://10734984606",["lucide-timer-off"]="rbxassetid://10734984138",["lucide-timer-reset"]="rbxassetid://10734984355",["lucide-toggle-left"]="rbxassetid://10734984834",["lucide-toggle-right"]="rbxassetid://10734985040",["lucide-tornado"]="rbxassetid://10734985247",["lucide-toy-brick"]="rbxassetid://10747361919",["lucide-train"]="rbxassetid://10747362105",["lucide-trash"]="rbxassetid://10747362393",["lucide-trash-2"]="rbxassetid://10747362241",["lucide-tree-deciduous"]="rbxassetid://10747362534",["lucide-tree-pine"]="rbxassetid://10747362748",["lucide-trees"]="rbxassetid://10747363016",["lucide-trending-down"]="rbxassetid://10747363205",["lucide-trending-up"]="rbxassetid://10747363465",["lucide-triangle"]="rbxassetid://10747363621",["lucide-trophy"]="rbxassetid://10747363809",["lucide-truck"]="rbxassetid://10747364031",["lucide-tv"]="rbxassetid://10747364593",["lucide-tv-2"]="rbxassetid://10747364302",["lucide-type"]="rbxassetid://10747364761",["lucide-umbrella"]="rbxassetid://10747364971",["lucide-underline"]="rbxassetid://10747365191",["lucide-undo"]="rbxassetid://10747365484",["lucide-undo-2"]="rbxassetid://10747365359",["lucide-unlink"]="rbxassetid://10747365771",["lucide-unlink-2"]="rbxassetid://10747397871",["lucide-unlock"]="rbxassetid://10747366027",["lucide-upload"]="rbxassetid://10747366434",["lucide-upload-cloud"]="rbxassetid://10747366266",["lucide-usb"]="rbxassetid://10747366606",["lucide-user"]="rbxassetid://10747373176",["lucide-user-check"]="rbxassetid://10747371901",["lucide-user-cog"]="rbxassetid://10747372167",["lucide-user-minus"]="rbxassetid://10747372346",["lucide-user-plus"]="rbxassetid://10747372702",["lucide-user-x"]="rbxassetid://10747372992",["lucide-users"]="rbxassetid://10747373426",["lucide-utensils"]="rbxassetid://10747373821",["lucide-utensils-crossed"]="rbxassetid://10747373629",["lucide-venetian-mask"]="rbxassetid://10747374003",["lucide-verified"]="rbxassetid://10747374131",["lucide-vibrate"]="rbxassetid://10747374489",["lucide-vibrate-off"]="rbxassetid://10747374269",["lucide-video"]="rbxassetid://10747374938",["lucide-video-off"]="rbxassetid://10747374721",["lucide-view"]="rbxassetid://10747375132",["lucide-voicemail"]="rbxassetid://10747375281",["lucide-volume"]="rbxassetid://10747376008",["lucide-volume-1"]="rbxassetid://10747375450",["lucide-volume-2"]="rbxassetid://10747375679",["lucide-volume-x"]="rbxassetid://10747375880",["lucide-wallet"]="rbxassetid://10747376205",["lucide-wand"]="rbxassetid://10747376565",["lucide-wand-2"]="rbxassetid://10747376349",["lucide-watch"]="rbxassetid://10747376722",["lucide-waves"]="rbxassetid://10747376931",["lucide-webcam"]="rbxassetid://10747381992",["lucide-wifi"]="rbxassetid://10747382504",["lucide-wifi-off"]="rbxassetid://10747382268",["lucide-wind"]="rbxassetid://10747382750",["lucide-wrap-text"]="rbxassetid://10747383065",["lucide-wrench"]="rbxassetid://10747383470",["lucide-x"]="rbxassetid://10747384394",["lucide-x-circle"]="rbxassetid://10747383819",["lucide-x-octagon"]="rbxassetid://10747384037",["lucide-x-square"]="rbxassetid://10747384217",["lucide-zoom-in"]="rbxassetid://10747384552",["lucide-zoom-out"]="rbxassetid://10747384679"}};
	end;
	a.f = function()
		local b = game:GetService("RunService");
		local c, d, e, f, g = b.Heartbeat, game:GetService("UserInputService"), game:GetService("TweenService"), a.load("e"), {Font="rbxassetid://12187365364",Theme=nil,Objects={},DefaultProperties={ScreenGui={ResetOnSpawn=false,ZIndexBehavior="Sibling"},CanvasGroup={BorderSizePixel=0,BackgroundColor3=Color3.new(1, 1, 1)},Frame={BorderSizePixel=0,BackgroundColor3=Color3.new(1, 1, 1)},TextLabel={BackgroundColor3=Color3.new(1, 1, 1),BorderSizePixel=0,Text="",TextColor3=Color3.new(1, 1, 1),TextSize=14},TextButton={BackgroundColor3=Color3.new(1, 1, 1),BorderSizePixel=0,Text="",AutoButtonColor=false,TextColor3=Color3.new(1, 1, 1),TextSize=14},TextBox={BackgroundColor3=Color3.new(1, 1, 1),BorderColor3=Color3.new(0, 0, 0),ClearTextOnFocus=false,Text="",TextColor3=Color3.new(0, 0, 0),TextSize=14},ImageLabel={BackgroundTransparency=1,BackgroundColor3=Color3.new(1, 1, 1),BorderSizePixel=0},ImageButton={BackgroundColor3=Color3.new(1, 1, 1),BorderSizePixel=0,AutoButtonColor=false},UIListLayout={SortOrder="LayoutOrder"}}};
		g.SetTheme = function(h)
			g.Theme = h;
		end;
		local h = function(h, i)
			if i.ThemeTag then
				g.AddThemeObject(h, i.ThemeTag);
			end
		end;
		g.GetThemeProperty = function(i, j)
			return j[i];
		end;
		g.AddThemeObject = function(i, j)
			local k = #g.Objects + 1;
			local l = {Object=i,Properties=j,Index=k};
			g.Objects[i] = l;
			g.UpdateTheme();
			return i;
		end;
		g.UpdateTheme = function()
			for i, j in next, g.Objects do
				for k, l in next, j.Properties do
					g.Tween(i, 0.08, {[k]=Color3.fromHex(g.GetThemeProperty(l, g.Theme))}):Play();
				end
			end
		end;
		g.Icon = function(i)
			return f.assets["lucide-" .. i];
		end;
		g.New = function(i, j, k)
			local l = Instance.new(i);
			for m, n in next, g.DefaultProperties[i] or {} do
				l[m] = n;
			end
			for o, p in next, j or {} do
				if (o ~= "ThemeTag") then
					l[o] = p;
				end
			end
			for q, r in next, k or {} do
				r.Parent = l;
			end
			h(l, j);
			return l;
		end;
		g.Tween = function(i, j, k, ...)
			return e:Create(i, TweenInfo.new(j, ...), k);
		end;
		g.Drag = function(i)
			local j, k, l, o;
			local p = function(p)
				local q = p.Position - l;
				i.Position = UDim2.new(o.X.Scale, o.X.Offset + q.X, o.Y.Scale, o.Y.Offset + q.Y);
			end;
			i.InputBegan:Connect(function(q)
				if ((q.UserInputType == Enum.UserInputType.MouseButton1) or (q.UserInputType == Enum.UserInputType.Touch)) then
					j = true;
					l = q.Position;
					o = i.Position;
					q.Changed:Connect(function()
						if (q.UserInputState == Enum.UserInputState.End) then
							j = false;
						end
					end);
				end
			end);
			i.InputChanged:Connect(function(q)
				if ((q.UserInputType == Enum.UserInputType.MouseMovement) or (q.UserInputType == Enum.UserInputType.Touch)) then
					k = q;
				end
			end);
			d.InputChanged:Connect(function(q)
				if ((q == k) and j) then
					p(q);
				end
			end);
		end;
		g.Blur = function(i)
			local j, k, l, o = game:GetService("RunService"), workspace.CurrentCamera, "Glass", {};
			local p = Instance.new("Folder", k);
			p.Name = "BlurSnox";
			local q = 99999999;
			local r, s = math.random(1, q), Instance.new("DepthOfFieldEffect", game:GetService("Lighting"));
			s.FarIntensity = 0;
			s.FocusDistance = 51.6;
			s.InFocusRadius = 50;
			s.NearIntensity = 1.5;
			s.Name = "DPT_" .. r;
			local t = Instance.new("Frame");
			t.Parent = i;
			t.Size = UDim2.new(0.95, 0, 0.95, 0);
			t.Position = UDim2.new(0.5, 0, 0.5, 0);
			t.AnchorPoint = Vector2.new(0.5, 0.5);
			t.BackgroundTransparency = 1;
			local u;
			do
				local v = 0;
				function u()
					v = v + 1;
					return "neon::" .. tostring(v);
				end
			end
			do
				local v = function(v)
					return v == v;
				end;
				local w = v(k:ScreenPointToRay(0, 0).Origin.x);
				while not w do
					j.RenderStepped:wait();
					w = v(k:ScreenPointToRay(0, 0).Origin.x);
				end
			end
			local v;
			do
				local w, x, y, z, A = math.acos, math.max, math.pi, math.sqrt, 0.2;
				function DrawTriangle(B, C, D, E, F)
					local G, H, I = (B - C).magnitude, (C - D).magnitude, (D - B).magnitude;
					local J, K, L, M = (x(G, H, I));
					if (G == J) then
						K, L, M = B, C, D;
					elseif (H == J) then
						K, L, M = C, D, B;
					elseif (I == J) then
						K, L, M = D, B, C;
					end
					local N = (((L - K).x * (M - K).x) + ((L - K).y * (M - K).y) + ((L - K).z * (M - K).z)) / (K - L).magnitude;
					local O, P, Q, R = z(((M - K).magnitude ^ 2) - (N * N)), (K - L).magnitude - N, CFrame.new(L, K), CFrame.Angles(y / 2, 0, 0);
					local S = Q;
					local T, U = (S * R).lookVector, K + (CFrame.new(K, L).lookVector * N);
					local V = CFrame.new(U, M).lookVector;
					local W = (T.x * V.x) + (T.y * V.y) + (T.z * V.z);
					local X = CFrame.Angles(0, 0, w(W));
					S = S * X;
					if (((S * R).lookVector - V).magnitude > 0.01) then
						S = S * CFrame.Angles(0, 0, -2 * w(W));
					end
					S = S * CFrame.new(0, O / 2, -(P + (N / 2)));
					local Y = Q * X * CFrame.Angles(0, y, 0);
					if (((Y * R).lookVector - V).magnitude > 0.01) then
						Y = Y * CFrame.Angles(0, 0, 2 * w(W));
					end
					Y = Y * CFrame.new(0, O / 2, P / 2);
					if not E then
						E = Instance.new("Part");
						E.FormFactor = "Custom";
						E.TopSurface = 0;
						E.BottomSurface = 0;
						E.Anchored = true;
						E.CanCollide = false;
						E.CastShadow = false;
						E.Material = l;
						E.Size = Vector3.new(A, A, A);
						local Z = Instance.new("SpecialMesh", E);
						Z.MeshType = 2;
						Z.Name = "WedgeMesh";
					end
					E.WedgeMesh.Scale = Vector3.new(0, O / A, N / A);
					E.CFrame = S;
					if not F then
						F = E:clone();
					end
					F.WedgeMesh.Scale = Vector3.new(0, O / A, P / A);
					F.CFrame = Y;
					return E, F;
				end
				function v(B, C, D, E, F)
					F[1], F[2] = DrawTriangle(B, C, D, F[1], F[2]);
					F[3], F[4] = DrawTriangle(D, C, E, F[3], F[4]);
				end
			end
			if o[t] then
				return o[t].parts;
			end
			local w, x, y = u(), {}, Instance.new("Folder", p);
			y.Name = t.Name;
			local z = {};
			do
				local function A(B)
					if B:IsA("GuiObject") then
						z[#z + 1] = B;
						A(B.Parent);
					end
				end
				A(t);
			end
			local A = function(A)
				if i.Visible then
					local B, C, D, E = {Transparency=0.98,BrickColor=BrickColor.new("Institutional white")}, 1 - (0.05 * t.ZIndex), t.AbsolutePosition, t.AbsolutePosition + t.AbsoluteSize;
					local F, G = Vector2.new(E.x, D.y), Vector2.new(D.x, E.y);
					do
						local H = 0;
						for I, J in ipairs(z) do
							H = H + J.Rotation;
						end
						if ((H ~= 0) and ((H % 180) ~= 0)) then
							local K, L, M = D:lerp(E, 0.5), math.sin(math.rad(H)), math.cos(math.rad(H));
							D = Vector2.new((M * (D.x - K.x)) - (L * (D.y - K.y)), (L * (D.x - K.x)) + (M * (D.y - K.y))) + K;
							F = Vector2.new((M * (F.x - K.x)) - (L * (F.y - K.y)), (L * (F.x - K.x)) + (M * (F.y - K.y))) + K;
							G = Vector2.new((M * (G.x - K.x)) - (L * (G.y - K.y)), (L * (G.x - K.x)) + (M * (G.y - K.y))) + K;
							E = Vector2.new((M * (E.x - K.x)) - (L * (E.y - K.y)), (L * (E.x - K.x)) + (M * (E.y - K.y))) + K;
						end
					end
					v(k:ScreenPointToRay(D.x, D.y, C).Origin, k:ScreenPointToRay(F.x, F.y, C).Origin, k:ScreenPointToRay(G.x, G.y, C).Origin, k:ScreenPointToRay(E.x, E.y, C).Origin, x);
					if A then
						for H, I in pairs(x) do
							I.Parent = y;
						end
						for J, K in pairs(B) do
							for L, M in pairs(x) do
								M[J] = K;
							end
						end
					end
				end
			end;
			A(true);
			j:BindToRenderStep(w, 2000, A);
		end;
		return g;
	end;
	a.g = function()
		local b = a.load("f");
		local c, d, e = b.New, b.Tween, {Size=UDim2.new(0, 300, 1, -156),UICorner=10,UIPadding=15,ButtonPadding=9,Holder=nil,NotificationIndex=0,Notifications={}};
		e.Init = function(f)
			return c("Frame", {Position=UDim2.new(1, -29, 0, 56),AnchorPoint=Vector2.new(1, 0),Size=e.Size,Parent=f,BackgroundTransparency=1}, {c("UIListLayout", {HorizontalAlignment="Center",SortOrder="LayoutOrder",VerticalAlignment="Bottom",Padding=UDim.new(0, 8)})});
		end;
		e.New = function(f)
			local g = {Title=(f.Title or "Notification"),Content=(f.Content or nil),Duration=f.Duration,Callback=f.Callback,CanClose=f.CanClose,UIElements={},Closed=false};
			if (g.CanClose == nil) then
				g.CanClose = true;
			end
			e.NotificationIndex = e.NotificationIndex + 1;
			e.Notifications[e.NotificationIndex] = g;
			local h, i;
			if g.Duration then
				i = c("Frame", {Name="Duration",Size=UDim2.new(1, 0, 1, 0),Position=UDim2.new(0, 0, 0, 0),ThemeTag={BackgroundColor3="Outline"},BackgroundTransparency=0.9,ZIndex=999});
			end
			local j;
			if g.CanClose then
				j = c("ImageButton", {Size=UDim2.new(0, 18, 0, 18),Image=b.Icon("x"),Position=UDim2.new(1, -e.UIPadding, 0, e.UIPadding),AnchorPoint=Vector2.new(1, 0),ThemeTag={ImageColor3="Text"},BackgroundTransparency=1,ZIndex=999});
			end
			local k, l = {"Confirm","Cancel"};
			if g.Callback then
				l = c("Frame", {Size=UDim2.new(1, 0, 0, 0),AutomaticSize="Y",BackgroundTransparency=1,LayoutOrder=5}, {c("UIListLayout", {SortOrder="LayoutOrder",FillDirection="Horizontal",Padding=UDim.new(0, 5.5)})});
				for o, p in next, k do
					local q = c("TextButton", {Size=UDim2.new(1 / #k, -((((#k - 1) * 11) / 2) / #k), 0, 0),AutomaticSize="Y",ThemeTag={BackgroundColor3="Text",TextColor3=(((p == "Confirm") and "Accent") or "Text")},BackgroundTransparency=(((p == "Confirm") and 0.15) or 0.9),Text=p,FontFace=Font.new(b.Font, Enum.FontWeight.Medium),TextSize=15,Parent=l,LayoutOrder=(((p == "Confirm") and 0) or 1)}, {c("UICorner", {CornerRadius=UDim.new(0, e.UICorner - 6)}),c("UIPadding", {PaddingTop=UDim.new(0, e.ButtonPadding),PaddingLeft=UDim.new(0, e.ButtonPadding),PaddingRight=UDim.new(0, e.ButtonPadding),PaddingBottom=UDim.new(0, e.ButtonPadding)}),c("Frame", {Size=UDim2.new(1, e.ButtonPadding * 2, 1, e.ButtonPadding * 2),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=1,Position=UDim2.new(0.5, 0, 0.5, 0),AnchorPoint=Vector2.new(0.5, 0.5)}, {c("UICorner", {CornerRadius=UDim.new(0, e.UICorner - 6)})})});
					q.MouseButton1Click:Connect(function()
						pcall(g.Callback, p);
					end);
					q.MouseEnter:Connect(function()
						d(q.Frame, 0.1, {BackgroundTransparency=0.85}):Play();
					end);
					q.MouseLeave:Connect(function()
						d(q.Frame, 0.1, {BackgroundTransparency=1}):Play();
					end);
				end
			end
			g.UIElements.MainContainer = c("Frame", {Size=UDim2.new(1, 0, 0, 0),Parent=f.Holder,AnchorPoint=Vector2.new(0, 0),BackgroundTransparency=1}, {c("Frame", {Size=UDim2.new(1, 0, 1, 0),BackgroundTransparency=1,AnchorPoint=Vector2.new(0, 1),Position=UDim2.new(2, 0, 1, 0)}, {h,j,c("CanvasGroup", {Size=UDim2.new(1, 0, 0, 0),AutomaticSize="Y",BackgroundTransparency=1,Name="Frame",ZIndex=2}, {i,c("UICorner", {CornerRadius=UDim.new(0, e.UICorner)}),c("UIStroke", {Thickness=0.6,ThemeTag={Color="Outline"},Transparency=0.8}),c("Frame", {Size=UDim2.new(1, 0, 1, 0),BackgroundTransparency=1,ZIndex=999}, {c("UIPadding", {PaddingTop=UDim.new(0, e.UIPadding + 2),PaddingLeft=UDim.new(0, e.UIPadding),PaddingRight=UDim.new(0, e.UIPadding),PaddingBottom=UDim.new(0, e.UIPadding + 2)}),c("TextLabel", {Text=g.Title,ThemeTag={TextColor3="Text"},TextSize=16,FontFace=Font.new(b.Font, Enum.FontWeight.SemiBold),BackgroundTransparency=1,TextWrapped=true,AutomaticSize="Y",Size=UDim2.new(1, -18 - e.UIPadding, 0, 0),TextXAlignment="Left",LayoutOrder=1}),l,c("UIListLayout", {SortOrder="LayoutOrder",Padding=UDim.new(0, 11)})}),c("Frame", {BackgroundTransparency=0.15,Size=UDim2.new(1, 0, 1, 0),ThemeTag={BackgroundColor3="Accent"}}, {c("UICorner", {CornerRadius=UDim.new(0, e.UICorner)})})})})});
			if g.Content then
				c("TextLabel", {Text=g.Content,ThemeTag={TextColor3="Text"},TextSize=15,FontFace=Font.new(b.Font, Enum.FontWeight.Medium),TextTransparency=0.4,TextWrapped=true,BackgroundTransparency=1,AutomaticSize="Y",Size=UDim2.new(1, -18 - e.UIPadding, 0, 0),TextXAlignment="Left",LayoutOrder=1,Parent=g.UIElements.MainContainer.Frame.Frame.Frame});
			end
			task.spawn(function()
				d(g.UIElements.MainContainer.Frame, 0.4, {Position=UDim2.new(0, 0, 1, 0)}, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut):Play();
				if (e.NotificationIndex ~= 1) then
					g.UIElements.MainContainer.Frame.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
						d(g.UIElements.MainContainer, 0.2, {Size=UDim2.new(1, 0, 0, g.UIElements.MainContainer.Frame.Frame.AbsoluteSize.Y)}, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut):Play();
					end);
				else
					g.UIElements.MainContainer.Frame.Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
						g.UIElements.MainContainer.Size = UDim2.new(1, 0, 0, g.UIElements.MainContainer.Frame.Frame.AbsoluteSize.Y);
					end);
				end
			end);
			g.Close = function(o)
				if not g.Closed then
					d(g.UIElements.MainContainer.Frame, 0.4, {Position=UDim2.new(2, 0, 1, 0)}, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut):Play();
					g.Closed = true;
					task.spawn(function()
						task.wait(0.3);
						g.UIElements.MainContainer.Frame.Frame:Destroy();
						d(g.UIElements.MainContainer, 0.2, {Size=UDim2.new(1, 0, 0, 0)}, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut):Play();
						task.wait(0.35);
						g.UIElements.MainContainer:Destroy();
					end);
				end
			end;
			task.spawn(function()
				if i then
					d(i, g.Duration, {Size=UDim2.new(0, 0, 1, 0)}, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut):Play();
					task.wait(g.Duration);
					g:Close();
				end
			end);
			if j then
				j.MouseButton1Click:Connect(function()
					g:Close();
				end);
			end
			return g;
		end;
		return e;
	end;
	a.h = function()
		local b = a.load("f");
		local c, d = b.New, b.Tween;
		return function(e)
			local f = {Title=(e.Title or "Element"),Desc=(e.Desc or nil),Hover=e.Hover,UIPadding=11,UIElements={}};
			f.UIElements.Main = c("TextButton", {Size=UDim2.new(1, 0, 0, 0),AutomaticSize="Y",BackgroundTransparency=0.98,BackgroundColor3=Color3.fromHex(e.Theme.Text),ThemeTag={BackgroundColor3="Text"}}, {c("UICorner", {CornerRadius=UDim.new(0, 6)}),c("Frame", {Size=UDim2.new(0, 0, 0, 0),AutomaticSize="XY",BackgroundTransparency=1,Name="Title"}, {c("UIListLayout", {Padding=UDim.new(0, 6)}),c("TextLabel", {Text=f.Title,TextColor3=Color3.fromHex(e.Theme.Text),ThemeTag={TextColor3="Text"},TextSize=15,TextWrapped=true,Name="Title",TextXAlignment="Left",Size=UDim2.new(1, -e.TextOffset, 0, 0),FontFace=Font.new(b.Font, Enum.FontWeight.Medium),BackgroundTransparency=1,AutomaticSize="Y"})}),c("Frame", {Size=UDim2.new(1, f.UIPadding * 2, 1, (f.UIPadding * 2) + 6),BackgroundColor3=Color3.fromHex(e.Theme.Text),ThemeTag={BackgroundColor3="Text"},Position=UDim2.new(0.5, 0, 0.5, 0),AnchorPoint=Vector2.new(0.5, 0.5),BackgroundTransparency=1,Name="Highlight"}, {c("UICorner", {CornerRadius=UDim.new(0, 6)})}),c("UIPadding", {PaddingTop=UDim.new(0, f.UIPadding + 3),PaddingLeft=UDim.new(0, f.UIPadding),PaddingRight=UDim.new(0, f.UIPadding),PaddingBottom=UDim.new(0, f.UIPadding + 3)}),c("UIStroke", {Thickness=0.8,Color=Color3.fromHex(e.Theme.Text),ThemeTag={Color="Text"},Transparency=0.94,ApplyStrokeMode="Border"})});
			f.UIElements.MainContainer = c("Frame", {Size=UDim2.new(1, 0, 0, 0),AutomaticSize="Y",BackgroundTransparency=1,Parent=e.Parent}, {f.UIElements.Main,c("UIPadding", {PaddingTop=UDim.new(0, 1),PaddingLeft=UDim.new(0, 1),PaddingRight=UDim.new(0, 1),PaddingBottom=UDim.new(0, 1)})});
			local g;
			if f.Desc then
				g = c("TextLabel", {Text=f.Desc,TextColor3=Color3.fromHex(e.Theme.Text),ThemeTag={TextColor3="Text"},TextTransparency=0.4,TextSize=15,TextWrapped=true,TextXAlignment="Left",Size=UDim2.new(1, -e.TextOffset, 0, 0),FontFace=Font.new(b.Font, Enum.FontWeight.Medium),BackgroundTransparency=1,AutomaticSize="Y",Parent=f.UIElements.Main.Title});
			else
				f.UIElements.Main.Title.AnchorPoint = Vector2.new(0, 0.5);
				f.UIElements.Main.Title.Position = UDim2.new(0, 0, 0.5, 0);
			end
			if f.Hover then
				f.UIElements.Main.MouseEnter:Connect(function()
					d(f.UIElements.Main.Highlight, 0.08, {BackgroundTransparency=0.97}):Play();
				end);
				f.UIElements.Main.MouseLeave:Connect(function()
					d(f.UIElements.Main.Highlight, 0.08, {BackgroundTransparency=1}):Play();
				end);
			end
			f.SetTitle = function(h, i)
				f.UIElements.Main.Title.Title.Text = i;
			end;
			f.SetDesc = function(h, i)
				if g then
					g.Text = i;
				else
					g = c("TextLabel", {Text=i,TextColor3=Color3.fromHex(e.Theme.Text),ThemeTag={TextColor3="Text"},TextTransparency=0.4,TextSize=15,TextWrapped=true,TextXAlignment="Left",Size=UDim2.new(1, -e.TextOffset, 0, 0),FontFace=Font.new(b.Font, Enum.FontWeight.Medium),BackgroundTransparency=1,AutomaticSize="Y",Parent=f.UIElements.Main.Title});
				end
			end;
			return f;
		end;
	end;
	a.i = function()
		local b = a.load("f");
		local c, d = b.New, {};
		d.New = function(e, f)
			local g = {__type="Button",Title=(f.Title or "Button"),Desc=(f.Desc or nil),Callback=(f.Callback or function()
			end),UIElements={}};
			g.ButtonFrame = a.load("h")({Title=g.Title,Desc=g.Desc,Parent=f.Parent,Theme=f.Theme,TextOffset=20,Hover=true});
			g.UIElements.ButtonIcon = c("ImageLabel", {Image=b.Icon("fingerprint"),BackgroundTransparency=1,Parent=g.ButtonFrame.UIElements.Main,Size=UDim2.new(0, 20, 0, 20),AnchorPoint=Vector2.new(1, 0.5),Position=UDim2.new(1, 0, 0.5, 0),ImageColor3=Color3.fromHex(f.Theme.Text),ThemeTag={ImageColor3="Text"}});
			g.ButtonFrame.UIElements.Main.MouseButton1Click:Connect(function()
				task.spawn(function()
					pcall(g.Callback);
				end);
			end);
			return g.__type, g;
		end;
		return d;
	end;
	a.j = function()
		local b = a.load("f");
		local c, d, e = b.New, b.Tween, {};
		e.New = function(f, g)
			local h = {__type="Toggle",Title=(g.Title or "Toggle"),Desc=(g.Desc or nil),Value=g.Value,Callback=(g.Callback or function()
			end),UIElements={}};
			h.ToggleFrame = a.load("h")({Title=h.Title,Desc=h.Desc,Parent=g.Parent,Theme=g.Theme,TextOffset=44,Hover=true});
			if (h.Value == nil) then
				h.Value = false;
			end
			h.UIElements.Toggle = c("Frame", {BackgroundTransparency=0.95,BackgroundColor3=Color3.fromHex(g.Theme.Text),ThemeTag={BackgroundColor3="Text"},Parent=h.ToggleFrame.UIElements.Main,Size=UDim2.new(0, 44, 0, 24),AnchorPoint=Vector2.new(1, 0.5),Position=UDim2.new(1, 0, 0.5, 0)}, {c("UICorner", {CornerRadius=UDim.new(1, 0)}),c("UIStroke", {Color=Color3.fromHex(g.Theme.Text),ThemeTag={Color="Text"},Transparency=0.93,Thickness=1}),c("Frame", {Size=UDim2.new(0, 18, 0, 18),Position=UDim2.new(0, 3, 0.5, 0),AnchorPoint=Vector2.new(0, 0.5),BackgroundTransparency=0.15,BackgroundColor3=Color3.fromHex(g.Theme.Text),ThemeTag={BackgroundColor3="Text"}}, {c("UICorner", {CornerRadius=UDim.new(1, 0)}),c("Frame", {Size=UDim2.new(1, 0, 1, 0),BackgroundTransparency=1,ThemeTag={BackgroundColor3="Accent"}}, {c("UICorner", {CornerRadius=UDim.new(1, 0)})})})});
			local i = h.Value;
			h.SetValue = function(j, k)
				i = k or i;
				if i then
					d(h.UIElements.Toggle.Frame, 0.1, {Position=UDim2.new(1, -21, 0.5, 0),BackgroundTransparency=1}):Play();
					d(h.UIElements.Toggle.Frame.Frame, 0.1, {BackgroundTransparency=0.15}):Play();
					d(h.UIElements.Toggle, 0.1, {BackgroundTransparency=0.15}):Play();
				else
					d(h.UIElements.Toggle.Frame, 0.1, {Position=UDim2.new(0, 3, 0.5, 0),BackgroundTransparency=0.15}):Play();
					d(h.UIElements.Toggle.Frame.Frame, 0.1, {BackgroundTransparency=1}):Play();
					d(h.UIElements.Toggle, 0.1, {BackgroundTransparency=0.95}):Play();
				end
			end;
			h:SetValue();
			task.spawn(function()
				pcall(h.Callback, i);
			end);
			i = not i;
			h.ToggleFrame.UIElements.Main.MouseButton1Click:Connect(function()
				h:SetValue();
				task.spawn(function()
					pcall(h.Callback, i);
				end);
				i = not i;
			end);
			return h.__type, h;
		end;
		return e;
	end;
	a.k = function()
		local b = a.load("f");
		local c, d, e = b.New, {}, false;
		d.New = function(f, g)
			local h, i, j, k = {__type="Slider",Title=(g.Title or "Slider"),Desc=(g.Desc or nil),Value=(g.Value or {}),Step=(g.Step or 1),Callback=(g.Callback or function()
			end),UIElements={},IsFocusing=false};
			local l = h.Value.Default or h.Value.Min or 0;
			local o, p = l, (l - (h.Value.Min or 0)) / ((h.Value.Max or 100) - (h.Value.Min or 0));
			h.SliderFrame = a.load("h")({Title=h.Title,Desc=h.Desc,Parent=g.Parent,Theme=g.Theme,TextOffset=85,Hover=false});
			h.UIElements.SliderIcon = c("ImageLabel", {ImageTransparency=0.9,BackgroundTransparency=1,Image="rbxassetid://18747052224",ScaleType="Crop",Size=UDim2.new(0, 126, 0, 3),Name="Frame",Position=UDim2.new(0.5, 0, 0.5, 0),AnchorPoint=Vector2.new(0.5, 0.5),ThemeTag={ImageColor3="Text"}}, {c("UICorner", {CornerRadius=UDim.new(1, 0)}),c("ImageLabel", {Name="Frame",Size=UDim2.new(p, 0, 1, 0),Image="rbxassetid://18747052224",ScaleType="Crop",BackgroundTransparency=1,ImageTransparency=0.4,ThemeTag={ImageColor3="Text"}}, {c("UICorner", {CornerRadius=UDim.new(1, 0)}),c("ImageLabel", {Size=UDim2.new(0, 13, 0, 13),Position=UDim2.new(1, 0, 0.5, 0),AnchorPoint=Vector2.new(0.5, 0.5),Image="rbxassetid://18747052224",BackgroundTransparency=1,ThemeTag={ImageColor3="Text"}})})});
			h.UIElements.SliderContainer = c("Frame", {Size=UDim2.new(0, 0, 0, 0),AutomaticSize="XY",AnchorPoint=Vector2.new(1, 0.5),Position=UDim2.new(1, 0, 0.5, 0),BackgroundTransparency=1,Parent=h.SliderFrame.UIElements.Main}, {c("UIListLayout", {Padding=UDim.new(0, 8),FillDirection="Horizontal",VerticalAlignment="Center"}),h.UIElements.SliderIcon,c("TextLabel", {Text=tostring(l),TextColor3=Color3.fromHex(g.Theme.Text),ThemeTag={TextColor3="Text"},TextTransparency=0.4,AutomaticSize="XY",TextSize=15,FontFace=Font.new(b.Font, Enum.FontWeight.Medium),BackgroundTransparency=1,LayoutOrder=-1})});
			h.UIElements.SliderContainer.InputBegan:Connect(function(q)
				if (not h.IsFocusing and not e and ((q.UserInputType == Enum.UserInputType.MouseButton1) or (q.UserInputType == Enum.UserInputType.Touch))) then
					i = q.UserInputType == Enum.UserInputType.Touch;
					h.SliderFrame.UIElements.Main.Parent.Parent.ScrollingEnabled = false;
					e = true;
					j = game:GetService("RunService").RenderStepped:Connect(function()
						local r;
						if i then
							r = q.Position.X;
						else
							r = game:GetService("UserInputService"):GetMouseLocation().X;
						end
						local s = math.clamp((r - h.UIElements.SliderIcon.AbsolutePosition.X) / h.UIElements.SliderIcon.Size.X.Offset, 0, 1);
						l = math.floor(((h.Value.Min + (s * (h.Value.Max - h.Value.Min))) / h.Step) + 0.5) * h.Step;
						if (l ~= o) then
							h.UIElements.SliderIcon.Frame.Size = UDim2.new(s, 0, 1, 0);
							h.UIElements.SliderContainer.TextLabel.Text = l;
							o = l;
							task.spawn(h.Callback, l);
						end
					end);
					k = game:GetService("UserInputService").InputEnded:Connect(function(r)
						if (((r.UserInputType == Enum.UserInputType.MouseButton1) or (r.UserInputType == Enum.UserInputType.Touch)) and (q == r)) then
							j:Disconnect();
							k:Disconnect();
							e = false;
							h.SliderFrame.UIElements.Main.Parent.Parent.ScrollingEnabled = true;
						end
					end);
				end
			end);
			return h.__type, h;
		end;
		return d;
	end;
	a.l = function()
		local b, c = game:GetService("UserInputService"), a.load("f");
		local d, e, f = c.New, c.Tween, {UICorner=6,UIPadding=8};
		f.New = function(g, h)
			local i = {__type="Keybind",Title=(h.Title or "Keybind"),Desc=(h.Desc or nil),Value=(h.Value or "F"),Callback=(h.Callback or function()
			end),CanChange=(h.CanChange or true),Picking=false,UIElements={}};
			i.KeybindFrame = a.load("h")({Title=i.Title,Desc=i.Desc,Parent=h.Parent,Theme=h.Theme,TextOffset=44,Hover=i.CanChange});
			i.UIElements.Keybind = d("TextLabel", {BackgroundTransparency=0.95,BackgroundColor3=Color3.fromHex(h.Theme.Text),Text=i.Value,TextColor3=Color3.fromHex(h.Theme.Text),TextSize=15,TextXAlignment="Right",AutomaticSize="XY",FontFace=Font.new(c.Font),Parent=i.KeybindFrame.UIElements.Main,Size=UDim2.new(0, 0, 0, 0),AnchorPoint=Vector2.new(1, 0.5),Position=UDim2.new(1, 0, 0.5, 0),ThemeTag={BackgroundColor3="Text",TextColor3="Text"},ZIndex=2}, {d("UICorner", {CornerRadius=UDim.new(0, f.UICorner)}),d("UIStroke", {Color=Color3.fromHex(h.Theme.Text),ThemeTag={Color="Text"},Transparency=0.93,ApplyStrokeMode="Border",Thickness=1}),d("UIPadding", {PaddingTop=UDim.new(0, f.UIPadding),PaddingLeft=UDim.new(0, f.UIPadding),PaddingRight=UDim.new(0, f.UIPadding),PaddingBottom=UDim.new(0, f.UIPadding)})});
			i.KeybindFrame.UIElements.Main.MouseButton1Click:Connect(function()
				if i.CanChange then
					i.Picking = true;
					i.UIElements.Keybind.Text = "...";
					task.wait(0.2);
					local j;
					j = b.InputBegan:Connect(function(k)
						local l;
						if (k.UserInputType == Enum.UserInputType.Keyboard) then
							l = k.KeyCode.Name;
						elseif (k.UserInputType == Enum.UserInputType.MouseButton1) then
							l = "MouseLeft";
						elseif (k.UserInputType == Enum.UserInputType.MouseButton2) then
							l = "MouseRight";
						end
						local o;
						o = b.InputEnded:Connect(function(p)
							if ((p.KeyCode.Name == l) or ((l == "MouseLeft") and (p.UserInputType == Enum.UserInputType.MouseButton1)) or ((l == "MouseRight") and (p.UserInputType == Enum.UserInputType.MouseButton2))) then
								i.Picking = false;
								i.UIElements.Keybind.Text = l;
								i.Value = l;
								j:Disconnect();
								o:Disconnect();
							end
						end);
					end);
				end
			end);
			b.InputBegan:Connect(function(j)
				if (j.KeyCode.Name == i.Value) then
					pcall(i.Callback, j.KeyCode.Name);
				end
			end);
			return i.__type, i;
		end;
		return f;
	end;
	a.m = function()
		local b = a.load("f");
		local c, d, e = b.New, b.Tween, {UICorner=6,UIPadding=8};
		e.New = function(f, g)
			local h = {__type="Input",Title=(g.Title or "Input"),Desc=(g.Desc or nil),PlaceholderText=(g.PlaceholderText or "Enter Text..."),Value=(g.Value or ""),Callback=(g.Callback or function()
			end),ClearTextOnFocus=(g.ClearTextOnFocus or false),UIElements={}};
			h.InputFrame = a.load("h")({Title=h.Title,Desc=h.Desc,Parent=g.Parent,Theme=g.Theme,TextOffset=70,Hover=false});
			h.UIElements.Input = c("Frame", {BackgroundTransparency=0.95,BackgroundColor3=Color3.fromHex(g.Theme.Text),Parent=h.InputFrame.UIElements.Main,Size=UDim2.new(0, 150, 0, 30),AnchorPoint=Vector2.new(1, 0.5),Position=UDim2.new(1, 0, 0.5, 0),ThemeTag={BackgroundColor3="Text"},ZIndex=2}, {c("TextBox", {MultiLine=false,Size=UDim2.new(1, 0, 0, 0),AutomaticSize="Y",BackgroundTransparency=1,Position=UDim2.new(0, 0, 0.5, 0),AnchorPoint=Vector2.new(0, 0.5),ClearTextOnFocus=h.ClearTextOnFocus,Text=h.Value,TextColor3=Color3.fromHex(g.Theme.Text),TextSize=15,ClipsDescendants=true,TextXAlignment="Left",FontFace=Font.new(b.Font),PlaceholderText=h.PlaceholderText,ThemeTag={TextColor3="Text",PlaceholderColor3="PlaceholderText"}}),c("UICorner", {CornerRadius=UDim.new(0, e.UICorner)}),c("UIStroke", {Color=Color3.fromHex(g.Theme.Text),ThemeTag={Color="Text"},Transparency=0.93,ApplyStrokeMode="Border",Thickness=1}),c("UIPadding", {PaddingTop=UDim.new(0, e.UIPadding),PaddingLeft=UDim.new(0, e.UIPadding),PaddingRight=UDim.new(0, e.UIPadding),PaddingBottom=UDim.new(0, e.UIPadding)})});
			h.UIElements.Input.TextBox.Focused:Connect(function()
				d(h.UIElements.Input.UIStroke, 0.1, {Transparency=0.8}):Play();
			end);
			h.UIElements.Input.TextBox.FocusLost:Connect(function()
				d(h.UIElements.Input.UIStroke, 0.1, {Transparency=0.93}):Play();
				pcall(h.Callback, h.UIElements.Input.TextBox.Text);
			end);
			return h.__type, h;
		end;
		return e;
	end;
	a.n = function()
		local b, c, d, e = game:GetService("UserInputService"), game:GetService("Players").LocalPlayer:GetMouse(), game:GetService("Workspace").CurrentCamera, a.load("f");
		local f, g, h = e.New, e.Tween, {UICorner=6,UIPadding=8,MenuCorner=14,MenuPadding=7,TabPadding=10};
		h.New = function(i, j)
			local k = {__type="Dropdown",Title=(j.Title or "Dropdown"),Desc=(j.Desc or nil),Values=(j.Values or {}),Value=j.Value,AllowNone=j.AllowNone,Multi=j.Multi,Callback=(j.Callback or function()
			end),UIElements={},Opened=false,Tabs={}};
			k.DropdownFrame = a.load("h")({Title=k.Title,Desc=k.Desc,Parent=j.Parent,Theme=j.Theme,TextOffset=70,Hover=false});
			k.UIElements.Dropdown = f("TextButton", {BackgroundTransparency=0.95,Text="",FontFace=Font.new(e.Font, Enum.FontWeight.Medium),TextSize=15,TextTransparency=0.4,TextXAlignment="Left",BackgroundColor3=Color3.fromHex(j.Theme.Text),Parent=k.DropdownFrame.UIElements.Main,Size=UDim2.new(0, 150, 0, 30),AnchorPoint=Vector2.new(1, 0.5),TextTruncate="AtEnd",Position=UDim2.new(1, 0, 0.5, 0),ThemeTag={BackgroundColor3="Text",TextColor3="Text"},ZIndex=2}, {f("UICorner", {CornerRadius=UDim.new(0, h.UICorner)}),f("UIStroke", {Color=Color3.fromHex(j.Theme.Text),ThemeTag={Color="Text"},Transparency=0.93,ApplyStrokeMode="Border",Thickness=1}),f("UIPadding", {PaddingTop=UDim.new(0, h.UIPadding),PaddingLeft=UDim.new(0, h.UIPadding),PaddingRight=UDim.new(0, (h.UIPadding * 2) + 18),PaddingBottom=UDim.new(0, h.UIPadding)}),f("ImageLabel", {Image=e.Icon("chevron-down"),Size=UDim2.new(0, 18, 0, 18),Position=UDim2.new(1, h.UIPadding + 18, 0.5, 0),ThemeTag={ImageColor3="Text"},AnchorPoint=Vector2.new(1, 0.5)})});
			k.UIElements.UIListLayout = f("UIListLayout", {Padding=UDim.new(0, h.MenuPadding / 1.5),FillDirection="Vertical"});
			k.UIElements.Menu = f("Frame", {ThemeTag={BackgroundColor3="Accent"},BackgroundTransparency=0.15,Size=UDim2.new(1, 0, 1, 0)}, {f("UISizeConstraint", {MinSize=Vector2.new(170, 0)}),f("UICorner", {CornerRadius=UDim.new(0, h.MenuCorner)}),f("UIStroke", {Thickness=1,Transparency=0.93,ThemeTag={Color="Text"}}),f("Frame", {BackgroundTransparency=1,Size=UDim2.new(1, 0, 1, 0),Name="CanvasGroup",ClipsDescendants=true}, {f("UIPadding", {PaddingTop=UDim.new(0, h.MenuPadding),PaddingLeft=UDim.new(0, h.MenuPadding),PaddingRight=UDim.new(0, h.MenuPadding),PaddingBottom=UDim.new(0, h.MenuPadding)}),f("ScrollingFrame", {Size=UDim2.new(1, 0, 1, 0),ScrollBarThickness=0,ScrollingDirection="Y",AutomaticCanvasSize="Y",CanvasSize=UDim2.new(0, 0, 0, 0),BackgroundTransparency=1}, {k.UIElements.UIListLayout})})});
			k.UIElements.MenuCanvas = f("Frame", {Size=UDim2.new(0, 170, 0, 300),BackgroundTransparency=1,Position=UDim2.new(-10, 0, -10, 0),Visible=false,Active=false,Parent=j.Window.SuperParent.Parent.Dropdowns}, {k.UIElements.Menu});
			local l, o = function()
				k.UIElements.Menu.CanvasGroup.ScrollingFrame.CanvasSize = UDim2.fromOffset(0, k.UIElements.UIListLayout.AbsoluteContentSize.Y);
			end, function()
				if (#k.Values > 10) then
					k.UIElements.MenuCanvas.Size = UDim2.fromOffset(k.UIElements.UIListLayout.AbsoluteContentSize.X, 392);
				else
					k.UIElements.MenuCanvas.Size = UDim2.fromOffset(k.UIElements.UIListLayout.AbsoluteContentSize.X, k.UIElements.UIListLayout.AbsoluteContentSize.Y + (h.MenuPadding * 2) + 1);
				end
			end;
			function UpdatePosition()
				local p = -35;
				if (((d.ViewportSize.Y - k.UIElements.Dropdown.AbsolutePosition.Y) + p) < (k.UIElements.MenuCanvas.AbsoluteSize.Y + 10)) then
					p = (k.UIElements.MenuCanvas.AbsoluteSize.Y - (d.ViewportSize.Y - k.UIElements.Dropdown.AbsolutePosition.Y)) + 10;
				end
				k.UIElements.MenuCanvas.Position = UDim2.fromOffset(k.UIElements.Dropdown.AbsolutePosition.X - 1, k.UIElements.Dropdown.AbsolutePosition.Y - p);
			end
			k.Display = function(p)
				local q, r = k.Values, "";
				if k.Multi then
					for s, t in next, q do
						if table.find(k.Value, t) then
							r = r .. t .. ", ";
						end
					end
					r = r:sub(1, #r - 2);
				else
					r = k.Value or "";
				end
				k.UIElements.Dropdown.Text = ((r == "") and "--") or r;
			end;
			k.Refresh = function(p, q)
				for r, s in next, k.UIElements.Menu.CanvasGroup.ScrollingFrame:GetChildren() do
					if not s:IsA("UIListLayout") then
						s:Destroy();
					end
				end
				k.Tabs = {};
				for t, u in next, q do
					task.wait(0.012);
					local v = {Name=u,Selected=false,UIElements={}};
					v.UIElements.TabItem = f("TextButton", {Size=UDim2.new(1, 0, 0, 0),AutomaticSize="Y",BackgroundTransparency=1,Parent=k.UIElements.Menu.CanvasGroup.ScrollingFrame,Text=u,TextXAlignment="Left",FontFace=Font.new(e.Font, Enum.FontWeight.Medium),ThemeTag={TextColor3="Text",BackgroundColor3="Text"},TextSize=15}, {f("UIPadding", {PaddingTop=UDim.new(0, h.TabPadding),PaddingLeft=UDim.new(0, h.TabPadding),PaddingRight=UDim.new(0, h.TabPadding),PaddingBottom=UDim.new(0, h.TabPadding)}),f("UICorner", {CornerRadius=UDim.new(0, h.MenuCorner - h.MenuPadding)})});
					if k.Multi then
						v.Selected = table.find(k.Value, v.Name);
					else
						v.Selected = k.Value == v.Name;
					end
					if v.Selected then
						v.UIElements.TabItem.BackgroundTransparency = 0.93;
					end
					k.Tabs[t] = v;
					local w = function()
						k:Display();
						task.spawn(function()
							pcall(k.Callback, k.Value);
						end);
					end;
					v.UIElements.TabItem.MouseButton1Click:Connect(function()
						if k.Multi then
							if not v.Selected then
								v.Selected = true;
								g(v.UIElements.TabItem, 0.1, {BackgroundTransparency=0.93}):Play();
								table.insert(k.Value, v.Name);
							else
								if (not k.AllowNone and (#k.Value == 1)) then
									return;
								end
								v.Selected = false;
								g(v.UIElements.TabItem, 0.1, {BackgroundTransparency=1}):Play();
								for x, y in ipairs(k.Value) do
									if (y == v.Name) then
										table.remove(k.Value, x);
										break;
									end
								end
							end
						else
							for x, y in next, k.Tabs do
								g(y.UIElements.TabItem, 0.1, {BackgroundTransparency=1}):Play();
								y.Selected = false;
							end
							v.Selected = true;
							g(v.UIElements.TabItem, 0.1, {BackgroundTransparency=0.93}):Play();
							k.Value = v.Name;
						end
						w();
					end);
					l();
					o();
				end
			end;
			k:Refresh(k.Values);
			k.Select = function(p, q)
				if q then
					k.Value = q;
				end
				k:Refresh(k.Values);
			end;
			k:Display();
			o();
			k.Open = function(p)
				k.Opened = true;
				k.UIElements.MenuCanvas.Visible = true;
				k.UIElements.MenuCanvas.Active = true;
				k.UIElements.Menu.Size = UDim2.new(1, 0, 0, 0);
				g(k.UIElements.Menu, 0.1, {Size=UDim2.new(1, 0, 1, 0)}, Enum.EasingStyle.Quart, Enum.EasingDirection.Out):Play();
				g(k.UIElements.Dropdown.ImageLabel, 0.15, {Rotation=180}):Play();
				UpdatePosition();
			end;
			k.Close = function(p)
				k.Opened = false;
				g(k.UIElements.Menu, 0.1, {Size=UDim2.new(1, 0, 0, 0)}, Enum.EasingStyle.Quart, Enum.EasingDirection.Out):Play();
				g(k.UIElements.Dropdown.ImageLabel, 0.15, {Rotation=0}):Play();
				task.wait(0.1);
				k.UIElements.MenuCanvas.Visible = false;
				k.UIElements.MenuCanvas.Active = false;
			end;
			k.UIElements.Dropdown.MouseButton1Click:Connect(function()
				k:Open();
			end);
			b.InputBegan:Connect(function(p)
				if ((p.UserInputType == Enum.UserInputType.MouseButton1) or (p.UserInputType == Enum.UserInputType.Touch)) then
					local q, r = k.UIElements.MenuCanvas.AbsolutePosition, k.UIElements.MenuCanvas.AbsoluteSize;
					if (j.Window.CanDropdown and ((c.X < q.X) or (c.X > (q.X + r.X)) or (c.Y < ((q.Y - 20) - 1)) or (c.Y > (q.Y + r.Y)))) then
						k:Close();
					end
				end
			end);
			k.UIElements.Dropdown:GetPropertyChangedSignal("AbsolutePosition"):Connect(UpdatePosition);
			return k.__type, k;
		end;
		return h;
	end;
	a.o = function()
		local b = a.load("f");
		local c, d, e = b.New, b.Tween, {UICorner=14,UIPadding=18,Holder=nil,Window=nil};
		e.Init = function(f)
			e.Window = f;
			return e;
		end;
		e.Create = function(f)
			local g = {UICorner=14,UIPadding=18,UIElements={}};
			if f then
				g.UIPadding = 24;
			end
			if f then
				g.UICorner = 16;
			end
			if not f then
				g.UIElements.FullScreen = c("Frame", {ZIndex=999,BackgroundTransparency=1,BackgroundColor3=Color3.new(0, 0, 0),Size=UDim2.new(1, 0, 1, 0),Active=false,Visible=false,Parent=((f and e.Window) or e.Window.UIElements.Main.Main)});
			end
			g.UIElements.Main = c("CanvasGroup", {ThemeTag={BackgroundColor3="Accent"},Visible=false,GroupTransparency=1,BackgroundTransparency=0,AutomaticSize="XY",Parent=((f and e.Window) or g.UIElements.FullScreen),Position=UDim2.new(0.5, 0, 0.5, 0),AnchorPoint=Vector2.new(0.5, 0.5)}, {c("UIScale", {Scale=0.9}),c("UICorner", {CornerRadius=UDim.new(0, g.UICorner)}),c("UIStroke", {Thickness=0.6,ThemeTag={Color="Outline"},Transparency=1}),c("UIPadding", {PaddingTop=UDim.new(0, g.UIPadding),PaddingLeft=UDim.new(0, g.UIPadding),PaddingRight=UDim.new(0, g.UIPadding),PaddingBottom=UDim.new(0, g.UIPadding)})});
			g.Open = function(h)
				if not f then
					g.UIElements.FullScreen.Visible = true;
					g.UIElements.FullScreen.Active = true;
				end
				task.spawn(function()
					task.wait(0.1);
					g.UIElements.Main.Visible = true;
					if not f then
						d(g.UIElements.FullScreen, 0.1, {BackgroundTransparency=0.5}):Play();
					end
					d(g.UIElements.Main, 0.1, {GroupTransparency=0}):Play();
					d(g.UIElements.Main.UIScale, 0.1, {Scale=1}):Play();
					d(g.UIElements.Main.UIStroke, 0.1, {Transparency=0.8}):Play();
				end);
			end;
			g.Close = function(h)
				if not f then
					d(g.UIElements.FullScreen, 0.1, {BackgroundTransparency=1}):Play();
					g.UIElements.FullScreen.Active = false;
					task.spawn(function()
						task.wait(0.1);
						g.UIElements.FullScreen.Visible = false;
					end);
				end
				d(g.UIElements.Main, 0.1, {GroupTransparency=1}):Play();
				d(g.UIElements.Main.UIScale, 0.1, {Scale=0.9}):Play();
				d(g.UIElements.Main.UIStroke, 0.1, {Transparency=1}):Play();
				return function()
					task.spawn(function()
						task.wait(0.1);
						if not f then
							g.UIElements.FullScreen:Destroy();
						else
							g.UIElements.Main:Destroy();
						end
					end);
				end;
			end;
			return g;
		end;
		return e;
	end;
	a.p = function()
		local b = a.load("f");
		local c, d, e, f, g, h = b.New, b.Tween, game:GetService("UserInputService"), game:GetService("TouchInputService"), game:GetService("RunService"), game:GetService("Players");
		local i, j = g.RenderStepped, h.LocalPlayer;
		local k, l = j:GetMouse(), {UICorner=6,UIPadding=8};
		l.Colorpicker = function(o, p, q)
			local r = {__type="Colorpicker",Title=p.Title,Desc=p.Desc,Default=p.Default,Callback=p.Callback,Transparency=p.Transparency,UIElements=p.UIElements};
			r.SetHSVFromRGB = function(s, t)
				local u, v, w = Color3.toHSV(t);
				r.Hue = u;
				r.Sat = v;
				r.Vib = w;
			end;
			r:SetHSVFromRGB(r.Default);
			local s = a.load("o").Init(p.Window);
			local t = s.Create();
			r.ColorpickerFrame = t;
			t:Close();
			local u, v, w = r.Hue, r.Sat, r.Vib;
			r.UIElements.Title = c("TextLabel", {Text="Colorpicker",TextSize=20,FontFace=Font.new(b.Font, Enum.FontWeight.SemiBold),TextXAlignment="Left",Size=UDim2.new(1, 0, 0, 0),AutomaticSize="Y",ThemeTag={TextColor3="Text"},BackgroundTransparency=1,Parent=t.UIElements.Main});
			local x = c("ImageLabel", {Size=UDim2.new(0, 18, 0, 18),ScaleType=Enum.ScaleType.Fit,AnchorPoint=Vector2.new(0.5, 0.5),BackgroundTransparency=1,Image="http://www.roblox.com/asset/?id=4805639000"});
			r.UIElements.SatVibMap = c("ImageLabel", {Size=UDim2.fromOffset(160, 158),Position=UDim2.fromOffset(0, 40),Image="rbxassetid://4155801252",BackgroundColor3=Color3.fromHSV(u, 1, 1),BackgroundTransparency=0,Parent=t.UIElements.Main}, {c("UICorner", {CornerRadius=UDim.new(0, 6)}),c("UIStroke", {Thickness=0.6,ThemeTag={Color="Text"},Transparency=0.8}),x});
			r.UIElements.Inputs = c("Frame", {AutomaticSize="XY",Position=UDim2.fromOffset((r.Transparency and 230) or 200, 40),BackgroundTransparency=1,Parent=t.UIElements.Main}, {c("UIListLayout", {Padding=UDim.new(0, 8),FillDirection="Vertical"})});
			local y = c("Frame", {BackgroundColor3=r.Default,Size=UDim2.fromScale(1, 1),BackgroundTransparency=r.Transparency}, {c("UICorner", {CornerRadius=UDim.new(0, 6)})});
			local z, A = c("ImageLabel", {Image="http://www.roblox.com/asset/?id=14204231522",ImageTransparency=0.45,ScaleType=Enum.ScaleType.Tile,TileSize=UDim2.fromOffset(40, 40),BackgroundTransparency=1,Position=UDim2.fromOffset(85, 208),Size=UDim2.fromOffset(75, 24),Parent=t.UIElements.Main}, {c("UICorner", {CornerRadius=UDim.new(0, 6)}),c("UIStroke", {Thickness=0.6,Transparency=0.8,ThemeTag={Color="Text"}}),y}), c("Frame", {BackgroundColor3=r.Default,Size=UDim2.fromScale(1, 1),BackgroundTransparency=0,ZIndex=9}, {c("UICorner", {CornerRadius=UDim.new(0, 4)})});
			local B, C = c("ImageLabel", {Image="http://www.roblox.com/asset/?id=14204231522",ImageTransparency=0.45,ScaleType=Enum.ScaleType.Tile,TileSize=UDim2.fromOffset(40, 40),BackgroundTransparency=1,Position=UDim2.fromOffset(0, 208),Size=UDim2.fromOffset(75, 24),Parent=t.UIElements.Main}, {c("UICorner", {CornerRadius=UDim.new(0, 4)}),c("UIStroke", {Thickness=0.6,Transparency=0.8,ThemeTag={Color="Text"}}),A}), {};
			for D = 0, 1, 0.1 do
				table.insert(C, ColorSequenceKeypoint.new(D, Color3.fromHSV(D, 1, 1)));
			end
			local D, E = c("UIGradient", {Color=ColorSequence.new(C),Rotation=90}), c("Frame", {Size=UDim2.new(1, 0, 1, 0),Position=UDim2.new(0, 0, 0, 0),BackgroundTransparency=1});
			local F, G = c("ImageLabel", {Size=UDim2.new(1, 0, 0, 3),Image="rbxassetid://18747052224",AnchorPoint=Vector2.new(0, 0.5),Parent=E,ScaleType="Crop",ThemeTag={ImageColor3="Text"}}), c("Frame", {Size=UDim2.fromOffset(20, 192),Position=UDim2.fromOffset(170, 40),Parent=t.UIElements.Main}, {c("UICorner", {CornerRadius=UDim.new(0, 6)}),D,E});
			function CreateInput(H, I)
				local J = c("Frame", {Size=UDim2.new(0, 120, 0, 0),AutomaticSize="Y",BackgroundTransparency=1,Parent=r.UIElements.Inputs}, {c("UIListLayout", {Padding=UDim.new(0, 10),FillDirection="Vertical"}),c("Frame", {BackgroundTransparency=0.95,Size=UDim2.new(1, 0, 0, 30),AnchorPoint=Vector2.new(1, 0.5),Position=UDim2.new(1, 0, 0.5, 0),ThemeTag={BackgroundColor3="Text"},ZIndex=2}, {c("TextBox", {MultiLine=false,Size=UDim2.new(1, -40, 0, 0),AutomaticSize="Y",BackgroundTransparency=1,Position=UDim2.new(0, 0, 0.5, 0),AnchorPoint=Vector2.new(0, 0.5),ClearTextOnFocus=false,Text=I,TextSize=15,ClipsDescendants=true,TextXAlignment="Left",FontFace=Font.new(b.Font),PlaceholderText="",ThemeTag={TextColor3="Text"}}),c("TextLabel", {Text=H,TextSize=16,FontFace=Font.new(b.Font, Enum.FontWeight.Medium),ThemeTag={TextColor3="Text"},BackgroundTransparency=1,TextXAlignment="Right",Position=UDim2.new(1, 0, 0.5, 0),AnchorPoint=Vector2.new(1, 0.5),Size=UDim2.new(0, 0, 0, 0),TextTransparency=0.4,AutomaticSize="XY"}),c("UICorner", {CornerRadius=UDim.new(0, l.UICorner)}),c("UIStroke", {ThemeTag={Color="Text"},Transparency=0.93,ApplyStrokeMode="Border",Thickness=1}),c("UIPadding", {PaddingTop=UDim.new(0, l.UIPadding),PaddingLeft=UDim.new(0, l.UIPadding),PaddingRight=UDim.new(0, l.UIPadding),PaddingBottom=UDim.new(0, l.UIPadding)})})});
				return J;
			end
			local H, I = function(H)
				return {R=math.floor(H.R * 255),G=math.floor(H.G * 255),B=math.floor(H.B * 255)};
			end, CreateInput("Hex", "#" .. r.Default:ToHex());
			local J, K, L, M = CreateInput("Red", H(r.Default).R), CreateInput("Green", H(r.Default).G), (CreateInput("Blue", H(r.Default).B));
			if r.Transparency then
				M = CreateInput("Alpha", ((1 - r.Transparency) * 100) .. "%");
			end
			local N, O = c("Frame", {Size=UDim2.new(1, 0, 0, 0),AutomaticSize="Y",Position=UDim2.new(0, 0, 0, 254),BackgroundTransparency=1,Parent=t.UIElements.Main,LayoutOrder=4}, {c("UIListLayout", {Padding=UDim.new(0, 8),FillDirection="Horizontal",HorizontalAlignment="Center"})}), {{Title="Cancel",Callback=function()
			end},{Title="Apply",Callback=function()
				pcall(q, Color3.fromHSV(r.Hue, r.Sat, r.Vib), r.Transparency);
			end}};
			for P, Q in next, O do
				local R = c("TextButton", {Text=(Q.Title or "Button"),TextSize=14,FontFace=Font.new(b.Font, Enum.FontWeight.Medium),ThemeTag={TextColor3="Text",BackgroundColor3="Text"},BackgroundTransparency=0.9,ZIndex=999999,Parent=N,Size=UDim2.new(1 / #O, -(((#O - 1) * 8) / #O), 0, 0),AutomaticSize="Y"}, {c("UICorner", {CornerRadius=UDim.new(0, t.UICorner - 7)}),c("UIPadding", {PaddingTop=UDim.new(0, t.UIPadding / 1.6),PaddingLeft=UDim.new(0, t.UIPadding / 1.6),PaddingRight=UDim.new(0, t.UIPadding / 1.6),PaddingBottom=UDim.new(0, t.UIPadding / 1.6)}),c("Frame", {Size=UDim2.new(1, (t.UIPadding / 1.6) * 2, 1, (t.UIPadding / 1.6) * 2),Position=UDim2.new(0.5, 0, 0.5, 0),AnchorPoint=Vector2.new(0.5, 0.5),ThemeTag={BackgroundColor3="Text"},BackgroundTransparency=1}, {c("UICorner", {CornerRadius=UDim.new(0, t.UICorner - 7)})})});
				R.MouseEnter:Connect(function()
					d(R.Frame, 0.1, {BackgroundTransparency=0.9}):Play();
				end);
				R.MouseLeave:Connect(function()
					d(R.Frame, 0.1, {BackgroundTransparency=1}):Play();
				end);
				R.MouseButton1Click:Connect(function()
					t:Close();
					task.spawn(function()
						pcall(Q.Callback);
					end);
				end);
			end
			local R, S, T;
			if r.Transparency then
				local U = c("Frame", {Size=UDim2.new(1, 0, 1, 0),Position=UDim2.fromOffset(0, 0),BackgroundTransparency=1});
				S = c("ImageLabel", {Size=UDim2.new(1, 0, 0, 3),AnchorPoint=Vector2.new(0, 0.5),Image="rbxassetid://18747052224",ScaleType="Crop",Parent=U,ThemeTag={ImageColor3="Text"}});
				T = c("Frame", {Size=UDim2.fromScale(1, 1)}, {c("UIGradient", {Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 0),NumberSequenceKeypoint.new(1, 1)}),Rotation=270}),c("UICorner", {CornerRadius=UDim.new(0, 6)})});
				R = c("Frame", {Size=UDim2.fromOffset(20, 192),Position=UDim2.fromOffset(200, 40),Parent=t.UIElements.Main,BackgroundTransparency=1}, {c("UICorner", {CornerRadius=UDim.new(1, 0)}),c("ImageLabel", {Image="rbxassetid://14204231522",ImageTransparency=0.45,ScaleType=Enum.ScaleType.Tile,TileSize=UDim2.fromOffset(40, 40),BackgroundTransparency=1,Size=UDim2.fromScale(1, 1)}, {c("UICorner", {CornerRadius=UDim.new(0, 6)})}),T,U});
			end
			r.Round = function(U, V, W)
				if (W == 0) then
					return math.floor(V);
				end
				V = tostring(V);
				return (V:find("%.") and tonumber(V:sub(1, V:find("%.") + W))) or V;
			end;
			r.Update = function(U, V, W)
				if V then
					u, v, w = Color3.toHSV(V);
				else
					u, v, w = r.Hue, r.Sat, r.Vib;
				end
				r.UIElements.SatVibMap.BackgroundColor3 = Color3.fromHSV(u, 1, 1);
				x.Position = UDim2.new(v, 0, 1 - w, 0);
				A.BackgroundColor3 = Color3.fromHSV(u, v, w);
				F.Position = UDim2.new(0, 0, u, 0);
				I.Frame.TextBox.Text = "#" .. Color3.fromHSV(u, v, w):ToHex();
				J.Frame.TextBox.Text = H(Color3.fromHSV(u, v, w)).R;
				K.Frame.TextBox.Text = H(Color3.fromHSV(u, v, w)).G;
				L.Frame.TextBox.Text = H(Color3.fromHSV(u, v, w)).B;
				if (W or r.Transparency) then
					T.BackgroundColor3 = Color3.fromHSV(u, v, w);
					A.BackgroundTransparency = r.Transparency or W;
					S.Position = UDim2.new(0, 0, (1 - r.Transparency) or W, 0);
					M.Frame.TextBox.Text = r:Round(((1 - r.Transparency) or W) * 100, 0) .. "%";
				end
			end;
			r:Update(r.Default, r.Transparency);
			local U = function()
				local U = Color3.fromHSV(r.Hue, r.Sat, r.Vib);
				return {R=math.floor(U.r * 255),G=math.floor(U.g * 255),B=math.floor(U.b * 255)};
			end;
			I.Frame.TextBox.FocusLost:Connect(function(V)
				if V then
					local W = I.Frame.TextBox.Text:gsub("#", "");
					local X, Y = pcall(Color3.fromHex, W);
					if (X and (typeof(Y) == "Color3")) then
						r.Hue, r.Sat, r.Vib = Color3.toHSV(Y);
						r:Update();
						r.Default = Y;
					end
				end
			end);
			J.Frame.TextBox.FocusLost:Connect(function(V)
				if V then
					local W = U();
					local X, Y = pcall(Color3.fromRGB, tonumber(J.Frame.TextBox.Text), W.G, W.B);
					if (X and (typeof(Y) == "Color3")) then
						if (tonumber(J.Frame.TextBox.Text) <= 255) then
							r.Hue, r.Sat, r.Vib = Color3.toHSV(Y);
							r:Update();
						end
					end
				end
			end);
			K.Frame.TextBox.FocusLost:Connect(function(V)
				if V then
					local W = U();
					local X, Y = pcall(Color3.fromRGB, W.R, tonumber(K.Frame.TextBox.Text), W.B);
					if (X and (typeof(Y) == "Color3")) then
						if (tonumber(K.Frame.TextBox.Text) <= 255) then
							r.Hue, r.Sat, r.Vib = Color3.toHSV(Y);
							r:Update();
						end
					end
				end
			end);
			L.Frame.TextBox.FocusLost:Connect(function(V)
				if V then
					local W = U();
					local X, Y = pcall(Color3.fromRGB, W.R, W.G, tonumber(L.Frame.TextBox.Text));
					if (X and (typeof(Y) == "Color3")) then
						if (tonumber(L.Frame.TextBox.Text) <= 255) then
							r.Hue, r.Sat, r.Vib = Color3.toHSV(Y);
							r:Update();
						end
					end
				end
			end);
			if r.Transparency then
				M.Frame.TextBox.FocusLost:Connect(function(V)
					if V then
						pcall(function()
							local W = tonumber(M.Frame.TextBox.Text);
							if ((W >= 0) and (W <= 100)) then
								r.Transparency = 1 - (W * 0.01);
								r:Update(nil, r.Transparency);
							end
						end);
					end
				end);
			end
			local V = r.UIElements.SatVibMap;
			V.InputBegan:Connect(function(W)
				if ((W.UserInputType == Enum.UserInputType.MouseButton1) or (W.UserInputType == Enum.UserInputType.Touch)) then
					while e:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
						local X = V.AbsolutePosition.X;
						local Y = X + V.AbsoluteSize.X;
						local Z, _ = math.clamp(k.X, X, Y), V.AbsolutePosition.Y;
						local aa = _ + V.AbsoluteSize.Y;
						local ab = math.clamp(k.Y, _, aa);
						r.Sat = (Z - X) / (Y - X);
						r.Vib = 1 - ((ab - _) / (aa - _));
						r:Update();
						i:Wait();
					end
				end
			end);
			G.InputBegan:Connect(function(aa)
				if ((aa.UserInputType == Enum.UserInputType.MouseButton1) or (aa.UserInputType == Enum.UserInputType.Touch)) then
					while e:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
						local ab = G.AbsolutePosition.Y;
						local W = ab + G.AbsoluteSize.Y;
						local X = math.clamp(k.Y, ab, W);
						r.Hue = (X - ab) / (W - ab);
						r:Update();
						i:Wait();
					end
				end
			end);
			if r.Transparency then
				R.InputBegan:Connect(function(aa)
					if ((aa.UserInputType == Enum.UserInputType.MouseButton1) or (aa.UserInputType == Enum.UserInputType.Touch)) then
						while e:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
							local ab = R.AbsolutePosition.Y;
							local W = ab + R.AbsoluteSize.Y;
							local X = math.clamp(k.Y, ab, W);
							r.Transparency = 1 - ((X - ab) / (W - ab));
							r:Update();
							i:Wait();
						end
					end
				end);
			end
			return r;
		end;
		l.New = function(aa, ab)
			local o = {__type="Colorpicker",Title=(ab.Title or "Colorpicker"),Desc=(ab.Desc or nil),Default=(ab.Default or Color3.new(1, 1, 1)),Callback=(ab.Callback or function()
			end),Window=ab.Window,Transparency=ab.Transparency,UIElements={}};
			o.ColorpickerFrame = a.load("h")({Title=o.Title,Desc=o.Desc,Parent=ab.Parent,Theme=ab.Theme,TextOffset=40,Hover=false});
			o.UIElements.Colorpicker = c("TextButton", {BackgroundTransparency=0,Text="",FontFace=Font.new(b.Font, Enum.FontWeight.Medium),TextSize=15,TextTransparency=0.4,Active=false,TextXAlignment="Left",BackgroundColor3=o.Default,Parent=o.ColorpickerFrame.UIElements.Main,Size=UDim2.new(0, 30, 0, 30),AnchorPoint=Vector2.new(1, 0.5),TextTruncate="AtEnd",Position=UDim2.new(1, 0, 0.5, 0),ThemeTag={TextColor3="Text"},ZIndex=2}, {c("UICorner", {CornerRadius=UDim.new(0, l.UICorner)}),c("UIStroke", {ThemeTag={Color="Text"},Transparency=0.93,ApplyStrokeMode="Border",Thickness=1})});
			o.Update = function(p, q, r)
				o.UIElements.Colorpicker.BackgroundTransparency = r or 0;
				o.UIElements.Colorpicker.BackgroundColor3 = q;
				o.Default = q;
				if r then
					o.Transparency = r;
				end
			end;
			local p = l:Colorpicker(o, function(p, q)
				o:Update(p, q);
				o.Default = p;
				o.Transparency = q;
				pcall(o.Callback, p, q);
			end);
			o:Update(o.Default, o.Transparency);
			o.UIElements.Colorpicker.MouseButton1Click:Connect(function()
				p.ColorpickerFrame:Open();
			end);
			return o.__type, o;
		end;
		return l;
	end;
	a.q = function()
		local aa = a.load("f");
		local ab, b, c = aa.New, aa.Tween, {};
		c.New = function(d, e)
			local f = {__type="Section",Title=(e.Title or "Section"),TextXAlignment=(e.TextXAlignment or "Left"),TextSize=(e.TextSize or 17),UIElements={}};
			f.UIElements.Main = ab("TextLabel", {BackgroundTransparency=1,TextXAlignment=f.TextXAlignment,AutomaticSize="Y",TextSize=f.TextSize,ThemeTag={TextColor3="Text"},FontFace=Font.new(aa.Font, Enum.FontWeight.SemiBold),Parent=e.Parent,Size=UDim2.new(1, 0, 0, 0),Text=f.Title}, {ab("UIPadding", {PaddingTop=UDim.new(0, 4),PaddingBottom=UDim.new(0, 2)})});
			f.SetTitle = function(g, h)
				f.UIElements.Main.Text = h;
			end;
			return f.__type, f;
		end;
		return c;
	end;
	a.r = function()
		local aa = a.load("f");
		local ab, b, c = aa.New, aa.Tween, {Window=nil,Tabs={},Containers={},SelectedTab=nil,TabCount=0};
		c.Init = function(d)
			c.Window = d;
			return c;
		end;
		c.New = function(d)
			local e, f = {Title=(d.Title or "Tab"),Icon=d.Icon,Selected=false,Index=nil,UIElements={},Elements={}}, c.Window;
			c.TabCount = c.TabCount + 1;
			local g = c.TabCount;
			e.Index = g;
			e.UIElements.Main = ab("TextButton", {BackgroundTransparency=1,Size=UDim2.new(1, 0, 0, 0),AutomaticSize="Y",Parent=d.Parent}, {ab("UIListLayout", {SortOrder="LayoutOrder",Padding=UDim.new(0, 10),FillDirection="Horizontal",VerticalAlignment="Center"}),ab("TextLabel", {Text=e.Title,TextColor3=Color3.fromHex(c.Window.Theme.Text),ThemeTag={TextColor3="Text"},TextTransparency=0.4,TextSize=15,Size=UDim2.new(1, 0, 0, 0),FontFace=Font.new(aa.Font, Enum.FontWeight.Medium),TextWrapped=true,AutomaticSize="Y",LayoutOrder=2,TextXAlignment="Left",BackgroundTransparency=1}),ab("UIPadding", {PaddingTop=UDim.new(0, 6),PaddingBottom=UDim.new(0, 6)})});
			if (e.Icon and aa.Icon(e.Icon)) then
				ab("ImageLabel", {ImageTransparency=0.4,Image=aa.Icon(e.Icon),Size=UDim2.new(0, 20, 0, 20),LayoutOrder=1,ImageColor3=Color3.fromHex(c.Window.Theme.Text),ThemeTag={ImageColor3="Text"},BackgroundTransparency=1,Parent=e.UIElements.Main});
				e.UIElements.Main.TextLabel.Size = UDim2.new(1, -22, 0, 0);
			end
			e.UIElements.ContainerFrame = ab("ScrollingFrame", {Size=UDim2.new(1, 0, 1, 0),BackgroundTransparency=1,ScrollBarThickness=0,CanvasSize=UDim2.new(0, 0, 0, 0),AutomaticCanvasSize="Y",Visible=false,ScrollingDirection="Y",Parent=f.UIElements.MainBar}, {ab("UIPadding", {PaddingTop=UDim.new(0, f.UIPadding),PaddingLeft=UDim.new(0, f.UIPadding),PaddingRight=UDim.new(0, f.UIPadding),PaddingBottom=UDim.new(0, f.UIPadding)}),ab("UIListLayout", {SortOrder="LayoutOrder",Padding=UDim.new(0, 6)})});
			c.Containers[g] = e.UIElements.ContainerFrame;
			c.Tabs[g] = e;
			e.UIElements.Main.MouseButton1Click:Connect(function()
				c:SelectTab(g);
			end);
			e.Paragraph = function(h, i)
				task.wait(0.01);
				local j = a.load("h")({Title=(i.Title or "Paragraph"),Desc=i.Desc,Parent=e.UIElements.ContainerFrame,Theme=c.Window.Theme,TextOffset=0,Hover=false});
				e.Elements.Paragraph = j;
				return j;
			end;
			e.Button = function(h, i)
				task.wait(0.01);
				local j, k = a.load("i"):New({Title=i.Title,Desc=i.Desc,Callback=i.Callback,Theme=c.Window.Theme,Parent=e.UIElements.ContainerFrame});
				e.Elements[j] = k;
				k.SetTitle = function(l, o)
					k.ButtonFrame:SetTitle(o);
				end;
				k.SetDesc = function(l, o)
					k.ButtonFrame:SetDesc(o);
				end;
				return k;
			end;
			e.Toggle = function(h, i)
				task.wait(0.01);
				local j, k = a.load("j"):New({Title=i.Title,Desc=i.Desc,Value=i.Value,Callback=i.Callback,Theme=c.Window.Theme,Parent=e.UIElements.ContainerFrame});
				e.Elements[j] = k;
				k.SetTitle = function(l, o)
					k.ToggleFrame:SetTitle(o);
				end;
				k.SetDesc = function(l, o)
					k.ToggleFrame:SetDesc(o);
				end;
				return k;
			end;
			e.Slider = function(h, i)
				task.wait(0.01);
				local j, k = a.load("k"):New({Title=i.Title,Desc=i.Desc,Step=i.Step,Value=i.Value,Callback=i.Callback,Theme=c.Window.Theme,Parent=e.UIElements.ContainerFrame});
				e.Elements[j] = k;
				k.SetTitle = function(l, o)
					k.SliderFrame:SetTitle(o);
				end;
				k.SetDesc = function(l, o)
					k.SliderFrame:SetDesc(o);
				end;
				return k;
			end;
			e.Keybind = function(h, i)
				task.wait(0.01);
				local j, k = a.load("l"):New({Title=i.Title,Desc=i.Desc,Value=i.Value,Callback=i.Callback,Theme=c.Window.Theme,Parent=e.UIElements.ContainerFrame});
				e.Elements[j] = k;
				k.SetTitle = function(l, o)
					k.KeybindFrame:SetTitle(o);
				end;
				k.SetDesc = function(l, o)
					k.KeybindFrame:SetDesc(o);
				end;
				return k;
			end;
			e.Input = function(h, i)
				task.wait(0.01);
				local j, k = a.load("m"):New({Title=i.Title,Desc=i.Desc,Value=i.Value,PlaceholderText=i.PlaceholderText,ClearTextOnFocus=i.ClearTextOnFocus,Callback=i.Callback,Theme=c.Window.Theme,Parent=e.UIElements.ContainerFrame});
				e.Elements[j] = k;
				k.SetTitle = function(l, o)
					k.InputFrame:SetTitle(o);
				end;
				k.SetDesc = function(l, o)
					k.InputFrame:SetDesc(o);
				end;
				return k;
			end;
			e.Dropdown = function(h, i)
				task.wait(0.01);
				local j, k = a.load("n"):New({Title=i.Title,Desc=i.Desc,AllowNone=i.AllowNone,Value=i.Value,Values=i.Values,Multi=i.Multi,Callback=i.Callback,Theme=c.Window.Theme,Parent=e.UIElements.ContainerFrame,Window=f});
				e.Elements[j] = k;
				k.SetTitle = function(l, o)
					k.DropdownFrame:SetTitle(o);
				end;
				k.SetDesc = function(l, o)
					k.DropdownFrame:SetDesc(o);
				end;
				return k;
			end;
			e.Colorpicker = function(h, i)
				task.wait(0.01);
				local j, k = a.load("p"):New({Title=i.Title,Desc=i.Desc,Default=i.Default,Transparency=i.Transparency,Callback=i.Callback,Parent=e.UIElements.ContainerFrame,Theme=c.Window.Theme,Window=f});
				e.Elements[j] = k;
				k.SetTitle = function(l, o)
					k.ColorpickerFrame:SetTitle(o);
				end;
				k.SetDesc = function(l, o)
					k.ColorpickerFrame:SetDesc(o);
				end;
				return k;
			end;
			e.Section = function(h, i)
				task.wait(0.01);
				local j, k = a.load("q"):New({Title=i.Title,TextXAlignment=i.TextXAlignment,TextSize=i.TextSize,Parent=e.UIElements.ContainerFrame});
				e.Elements[j] = k;
				return k;
			end;
			task.spawn(function()
				local h = ab("Frame", {BackgroundTransparency=1,Size=UDim2.new(1, 0, 1, -f.UIElements.Main.Main.Topbar.AbsoluteSize.Y),Parent=e.UIElements.ContainerFrame}, {ab("UIListLayout", {Padding=UDim.new(0, 8),SortOrder="LayoutOrder",VerticalAlignment="Center",HorizontalAlignment="Center",FillDirection="Vertical"}),ab("ImageLabel", {Size=UDim2.new(0, 48, 0, 48),Image=aa.Icon("frown"),ThemeTag={ImageColor3="Text"},BackgroundTransparency=1,ImageTransparency=0.4}),ab("TextLabel", {AutomaticSize="XY",Text="This tab is empty",TextColor3=Color3.fromHex(c.Window.Theme.Text),ThemeTag={TextColor3="Text"},TextSize=18,TextTransparency=0.4,BackgroundTransparency=1,FontFace=Font.new(aa.Font, Enum.FontWeight.Medium)})});
				e.UIElements.ContainerFrame.ChildAdded:Connect(function()
					h.Visible = false;
				end);
			end);
			return e;
		end;
		c.SelectTab = function(d, e)
			c.SelectedTab = e;
			for f, g in next, c.Tabs do
				b(g.UIElements.Main.TextLabel, 0.15, {TextTransparency=0.4}):Play();
				if (g.Icon and aa.Icon(g.Icon)) then
					b(g.UIElements.Main.ImageLabel, 0.15, {ImageTransparency=0.4}):Play();
				end
				g.Selected = false;
			end
			b(c.Tabs[e].UIElements.Main.TextLabel, 0.15, {TextTransparency=0}):Play();
			if (c.Tabs[e].Icon and aa.Icon(c.Tabs[e].Icon)) then
				b(c.Tabs[e].UIElements.Main.ImageLabel, 0.15, {ImageTransparency=0}):Play();
			end
			c.Tabs[e].Selected = true;
			task.spawn(function()
				for h, i in next, c.Containers do
					i.AnchorPoint = Vector2.new(0, 0.05);
					i.Visible = false;
				end
				c.Containers[e].Visible = true;
				b(c.Containers[e], 0.15, {AnchorPoint=Vector2.new(0, 0)}, Enum.EasingStyle.Quart, Enum.EasingDirection.Out):Play();
			end);
		end;
		return c;
	end;
	a.s = function()
		local aa, ab, b = game:GetService("UserInputService"), game:GetService("RunService"), a.load("f");
		local c, d, e = b.New, b.Tween, false;
		return function(f)
			local g = {Title=(f.Title or "UI Library"),Author=f.Author,Icon=f.Icon,Folder=f.Folder,Size=(f.Size or UDim2.fromOffset(560, 460)),ToggleKey=(f.ToggleKey or Enum.KeyCode.G),Transparent=(f.Transparent or false),Position=UDim2.new(0.5, 0, 0.5, 0),UICorner=9,UIPadding=14,SideBarWidth=(f.SideBarWidth or 200),UIElements={},Theme=f.Theme,CanDropdown=true,Closed=false,HasOutline=(f.HasOutline or false),SuperParent=f.Parent};
			if g.Folder then
				makefolder("WindUI/" .. g.Folder);
			end
			local h, i, j, k = c("UICorner", {CornerRadius=UDim.new(0, g.UICorner)}), c("UIStroke", {Thickness=0.6,Color=Color3.fromHex(f.Theme.Outline),ThemeTag={Color="Outline"},Transparency=1}), c("Frame", {Size=UDim2.new(0, 32, 0, 32),Position=UDim2.new(1, 0, 1, 0),AnchorPoint=Vector2.new(0.5, 0.5),BackgroundTransparency=1,ZIndex=99,Active=true}), c("Frame", {Size=UDim2.new(1, 0, 1, 0),BackgroundTransparency=1,BackgroundColor3=Color3.new(0, 0, 0),ZIndex=98,Active=false}, {c("ImageLabel", {Size=UDim2.new(0, 70, 0, 70),Image=b.Icon("expand"),BackgroundTransparency=1,Position=UDim2.new(0.5, 0, 0.5, 0),AnchorPoint=Vector2.new(0.5, 0.5),ImageTransparency=1}),c("UICorner", {CornerRadius=UDim.new(0, g.UICorner)})});
			g.UIElements.SideBar = c("ScrollingFrame", {Size=UDim2.new(0, g.SideBarWidth, 1, -g.UIPadding * 4),Position=UDim2.new(0, 0, 0, g.UIPadding * 4),BackgroundTransparency=1,ScrollBarThickness=0,CanvasSize=UDim2.new(0, 0, 0, 0),AutomaticCanvasSize="Y",ScrollingDirection="Y"}, {c("UIPadding", {PaddingTop=UDim.new(0, g.UIPadding),PaddingLeft=UDim.new(0, g.UIPadding + 4),PaddingRight=UDim.new(0, g.UIPadding + 4),PaddingBottom=UDim.new(0, g.UIPadding)}),c("UIListLayout", {SortOrder="LayoutOrder",Padding=UDim.new(0, 8)})});
			g.UIElements.MainBar = c("Frame", {Size=UDim2.new(1, -g.UIElements.SideBar.AbsoluteSize.X, 1, -g.UIPadding * 4),Position=UDim2.new(0, g.UIElements.SideBar.AbsoluteSize.X, 0, g.UIPadding * 4),BackgroundTransparency=1});
			local l, o, p, q, r = c("Frame", {Size=UDim2.new(1, 0, 1, 0),BackgroundTransparency=1,ZIndex=3,Name="Gradient"}, {c("UIGradient", {Color=ColorSequence.new(Color3.new(0, 0, 0), Color3.new(0, 0, 0)),Rotation=90,Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0, 1),NumberSequenceKeypoint.new(1, (g.Transparent and 0.85) or 0.7)})}),c("UICorner", {CornerRadius=UDim.new(0, g.UICorner)})}), c("ImageLabel", {Image="rbxassetid://8992230677",ImageColor3=Color3.new(0, 0, 0),ImageTransparency=1,Size=UDim2.new(1, 120, 1, 116),Position=UDim2.new(0, -60, 0, -58),ScaleType="Slice",SliceCenter=Rect.new(99, 99, 99, 99),BackgroundTransparency=1}), c("ImageButton", {Image=b.Icon("x"),BackgroundTransparency=1,Size=UDim2.new(1, -6, 1, -6),ThemeTag={ImageColor3="Text"},AnchorPoint=Vector2.new(0.5, 0.5),Position=UDim2.new(0.5, 0, 0.5, 0)}), (c("ImageButton", {Image=b.Icon("minus"),BackgroundTransparency=1,Size=UDim2.new(1, -6, 1, -6),ThemeTag={ImageColor3="Text"},AnchorPoint=Vector2.new(0.5, 0.5),Position=UDim2.new(0.5, 0, 0.5, 0)}));
			if (aa.TouchEnabled and not aa.KeyboardEnabled) then
				r = false;
			elseif aa.KeyboardEnabled then
				r = true;
			else
				r = nil;
			end
			local s, t;
			if not r then
				s = c("Frame", {Size=UDim2.new(0, 0, 0, 0),Position=UDim2.new(0.5, 0, 0, 28),AnchorPoint=Vector2.new(0.5, 0.5),Parent=f.Parent,BackgroundTransparency=1,Active=true,Visible=false});
				t = c("TextButton", {Size=UDim2.new(0, 0, 0, 44),AutomaticSize="XY",Parent=s,Active=false,BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0.3,ZIndex=99}, {c("UIScale", {Scale=1}),c("UICorner", {CornerRadius=UDim.new(1, 0)}),c("UIStroke", {Thickness=1,ApplyStrokeMode="Border",Color=Color3.new(1, 1, 1),Transparency=0}, {c("UIGradient", {Color=ColorSequence.new(Color3.fromHex("40c9ff"), Color3.fromHex("e81cff"))})}),c("ImageLabel", {Image=b.Icon("grab"),Size=UDim2.new(0, 20, 0, 20),BackgroundTransparency=1,Position=UDim2.new(0, 0, 0.5, 0),AnchorPoint=Vector2.new(0, 0.5)}),c("Frame", {Size=UDim2.new(0, 1, 1, -16),Position=UDim2.new(0, 36, 0.5, 0),AnchorPoint=Vector2.new(0, 0.5),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=0.86}),c("TextButton", {AutomaticSize="XY",Active=true,BackgroundTransparency=1,Size=UDim2.new(0, 0, 1, 0),Position=UDim2.new(0, 53, 0, 0)}, {c("ImageLabel", {Image="",Size=UDim2.new(0, 22, 0, 22),Position=UDim2.new(0.5, 0, 0.5, 0),LayoutOrder=-1,AnchorPoint=Vector2.new(0.5, 0.5),BackgroundTransparency=1,Name="Icon"}),c("UIListLayout", {Padding=UDim.new(0, g.UIPadding),FillDirection="Horizontal",VerticalAlignment="Center"}),c("TextLabel", {Text=g.Title,TextSize=17,FontFace=Font.new(b.Font, Enum.FontWeight.Medium),BackgroundTransparency=1,AutomaticSize="XY"})}),c("UIPadding", {PaddingTop=UDim.new(0, 0),PaddingLeft=UDim.new(0, 16),PaddingRight=UDim.new(0, 16),PaddingBottom=UDim.new(0, 0)})});
				local u, v = t.UIStroke.UIGradient, c("ImageLabel", {Image="rbxassetid://93831937596979",ScaleType="Slice",SliceCenter=Rect.new(375, 375, 375, 375),BackgroundTransparency=1,Size=UDim2.new(1, 21, 1, 21),Position=UDim2.new(0.5, 0, 0.5, 0),AnchorPoint=Vector2.new(0.5, 0.5),ImageTransparency=0.5,Parent=s}, {c("UIGradient", {Color=ColorSequence.new(Color3.fromHex("40c9ff"), Color3.fromHex("e81cff"))})});
				ab.RenderStepped:Connect(function(w)
					u.Rotation = (u.Rotation + 1) % 360;
					v.UIGradient.Rotation = (v.UIGradient.Rotation + 1) % 360;
				end);
				t:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
					s.Size = UDim2.new(0, t.AbsoluteSize.X, 0, t.AbsoluteSize.Y);
				end);
				t.TextButton.MouseEnter:Connect(function()
					d(t.UIScale, 0.1, {Scale=0.95}):Play();
				end);
				t.TextButton.MouseLeave:Connect(function()
					d(t.UIScale, 0.1, {Scale=1}):Play();
				end);
			end
			local u, v;
			if g.HasOutline then
				u = c("Frame", {Name="Outline",Size=UDim2.new(1, g.UIPadding * 2, 0, 1),Position=UDim2.new(0.5, 0, 1, g.UIPadding),BackgroundTransparency=0.8,AnchorPoint=Vector2.new(0.5, 0.5),ThemeTag={BackgroundColor3="Outline"}});
				v = c("Frame", {Name="Outline",Size=UDim2.new(0, 1, 1, -g.UIPadding * 4),Position=UDim2.new(0, g.SideBarWidth, 0, g.UIPadding * 4),BackgroundTransparency=0.8,AnchorPoint=Vector2.new(0.5, 0),ThemeTag={BackgroundColor3="Outline"}});
			end
			g.UIElements.Main = c("Frame", {Size=UDim2.new(0, math.clamp(g.Size.X.Offset, 400, 700), 0, math.clamp(g.Size.Y.Offset, 350, 520)),Position=g.Position,BackgroundTransparency=1,Parent=f.Parent,AnchorPoint=Vector2.new(0.5, 0.5),Active=true}, {o,l,c("Frame", {BackgroundColor3=Color3.fromHex(f.Theme.Accent),BackgroundTransparency=1,Size=UDim2.new(1, 0, 1, 0),Name="Background",ThemeTag={BackgroundColor3="Accent"},ZIndex=2}, {c("UICorner", {CornerRadius=UDim.new(0, g.UICorner)})}),i,h,j,k,c("UIScale", {Scale=0.9}),c("CanvasGroup", {Size=UDim2.new(1, 0, 1, 0),BackgroundTransparency=1,Name="Main",GroupTransparency=1,ZIndex=97}, {c("UICorner", {CornerRadius=UDim.new(0, g.UICorner)}),g.UIElements.SideBar,g.UIElements.MainBar,v,c("Frame", {Size=UDim2.new(1, 0, 0, g.UIPadding * 4),BackgroundTransparency=1,Name="Topbar"}, {u,c("Frame", {AutomaticSize="X",Size=UDim2.new(0, 0, 1, 0),BackgroundTransparency=1,Name="Left"}, {c("UIListLayout", {Padding=UDim.new(0, 10),SortOrder="LayoutOrder",FillDirection="Horizontal",VerticalAlignment="Center"}),c("Frame", {AutomaticSize="XY",BackgroundTransparency=1,Name="Title",LayoutOrder=2}, {c("UIListLayout", {Padding=UDim.new(0, 0),SortOrder="LayoutOrder",FillDirection="Vertical",VerticalAlignment="Top"}),c("TextLabel", {Text=g.Title,FontFace=Font.new(b.Font, Enum.FontWeight.Medium),BackgroundTransparency=1,AutomaticSize="XY",TextXAlignment="Left",TextSize=16,TextColor3=Color3.fromHex(f.Theme.Text),ThemeTag={TextColor3="Text"}})}),c("UIPadding", {PaddingLeft=UDim.new(0, 4)})}),c("Frame", {AutomaticSize="XY",BackgroundTransparency=1,Position=UDim2.new(1, 0, 0.5, 0),AnchorPoint=Vector2.new(1, 0.5)}, {c("UIListLayout", {Padding=UDim.new(0, 12),FillDirection="Horizontal",SortOrder="LayoutOrder"}),c("TextButton", {Size=UDim2.new(0, 24, 0, 24),BackgroundTransparency=1,LayoutOrder=1}, {p}),c("TextButton", {Size=UDim2.new(0, 24, 0, 24),BackgroundTransparency=1}, {q})}),c("UIPadding", {PaddingTop=UDim.new(0, g.UIPadding),PaddingLeft=UDim.new(0, g.UIPadding),PaddingRight=UDim.new(0, g.UIPadding),PaddingBottom=UDim.new(0, g.UIPadding)})})})});
			local w = false;
			b.Drag(g.UIElements.Main);
			if not r then
				b.Drag(s, function(x)
					w = x;
				end);
			end
			if g.Author then
				c("TextLabel", {Text=("by " .. g.Author),FontFace=Font.new(b.Font, Enum.FontWeight.Medium),BackgroundTransparency=1,TextTransparency=0.4,AutomaticSize="XY",Parent=g.UIElements.Main.Main.Topbar.Left.Title,TextXAlignment="Left",TextSize=14,LayoutOrder=2,TextColor3=Color3.fromHex(f.Theme.Text),ThemeTag={TextColor3="Text"}});
			end
			task.spawn(function()
				if g.Icon then
					local x = c("ImageLabel", {Parent=g.UIElements.Main.Main.Topbar.Left,Size=UDim2.new(0, 24, 0, 24),BackgroundTransparency=1,LayoutOrder=1,ThemeTag={ImageColor3="Text"}});
					if b.Icon(g.Icon) then
						x.Image = b.Icon(g.Icon);
						t.TextButton.Icon.Image = b.Icon(g.Icon);
					end
					if string.find(g.Icon, "http") then
						if not isfile(g.Folder .. "/Assets/Icon.png") then
							if not isfolder("WindUI" .. g.Folder) then
								makefolder("WindUI" .. g.Folder);
							end
							local y = request({Url=g.Icon,Method="GET"}).Body;
							writefile("WindUI" .. g.Folder .. "/Assets/Icon.png", y);
						end
						x.Image = getcustomasset("WindUI" .. g.Folder .. "/Assets/Icon.png");
						t.TextButton.Icon.Image = getcustomasset("WindUI" .. g.Folder .. "/Assets/Icon.png");
					elseif string.find(g.Icon, "rbxassetid") then
						x.Image = g.Icon;
						t.TextButton.Icon.Image = g.Icon;
					end
				elseif not r then
					t.TextButton.Icon.Image = b.Icon("external-link");
				end
			end);
			g.Open = function(x)
				g.Closed = false;
				d(g.UIElements.Main.Background, 0.25, {BackgroundTransparency=((f.Transparent and 0.15) or 0)}, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out):Play();
				d(g.UIElements.Main.Main, 0.25, {GroupTransparency=0}, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out):Play();
				d(g.UIElements.Main.UIScale, 0.25, {Scale=1}, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out):Play();
				d(l, 0.25, {BackgroundTransparency=0}, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out):Play();
				d(o, 0.25, {ImageTransparency=0.7}, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out):Play();
				d(i, 0.25, {Transparency=0.8}, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out):Play();
				g.CanDropdown = true;
				g.UIElements.Main.Visible = true;
			end;
			g.Close = function(x)
				local y = {};
				g.CanDropdown = false;
				g.Closed = true;
				d(g.UIElements.Main.Background, 0.25, {BackgroundTransparency=1}, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out):Play();
				d(g.UIElements.Main.Main, 0.25, {GroupTransparency=1}, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out):Play();
				d(g.UIElements.Main.UIScale, 0.25, {Scale=0.9}, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out):Play();
				d(l, 0.25, {BackgroundTransparency=1}, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out):Play();
				d(o, 0.25, {ImageTransparency=1}, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out):Play();
				d(i, 0.25, {Transparency=1}, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out):Play();
				task.spawn(function()
					task.wait(0.25);
					g.UIElements.Main.Visible = false;
				end);
				y.Destroy = function(z)
					task.wait(0.25);
					f.Parent.Parent:Destroy();
				end;
				return y;
			end;
			q.MouseButton1Click:Connect(function()
				g:Close();
				task.spawn(function()
					task.wait(0.3);
					if not r then
						s.Visible = true;
					end
				end);
				local x = (r and ("Press " .. g.Name .. " to open the Window")) or "Click the Button to open the Window";
				if not e then
					e = not e;
					f.WindUI({Title="Minimize",Content=("You've closed the Window. " .. x),Duration=5});
				end
			end);
			if not r then
				t.TextButton.MouseButton1Click:Connect(function()
					g:Open();
					s.Visible = false;
				end);
			end
			aa.InputBegan:Connect(function(x, y)
				if y then
					return;
				end
				if (x.KeyCode == g.ToggleKey) then
					if g.Closed then
						g:Open();
					else
						g:Close();
					end
				end
			end);
			task.spawn(function()
				g:Open();
			end);
			local x = a.load("r").Init(g);
			g.Tab = function(y, z)
				ab.Heartbeat:Wait();
				return x.New({Title=z.Title,Icon=z.Icon,Parent=g.UIElements.SideBar});
			end;
			g.SelectTab = function(y, z)
				x:SelectTab(z);
			end;
			local y = a.load("o").Init(g);
			g.Dialog = function(z, A)
				local B, C = {Title=(A.Title or "Dialog"),Content=A.Content,Buttons=(A.Buttons or {})}, y.Create();
				C.UIElements.UIListLayout = c("UIListLayout", {Padding=UDim.new(0, 18.4),FillDirection="Vertical",HorizontalAlignment="Center",Parent=C.UIElements.Main});
				c("UISizeConstraint", {MinSize=Vector2.new(50, 20),MaxSize=Vector2.new(620, math.huge),Parent=C.UIElements.Main});
				C.UIElements.Title = c("TextLabel", {Text=B.Title,TextSize=20,FontFace=Font.new(b.Font, Enum.FontWeight.SemiBold),TextXAlignment="Left",TextWrapped=true,RichText=true,Size=UDim2.new(1, 0, 0, 0),AutomaticSize="Y",ThemeTag={TextColor3="Text"},BackgroundTransparency=1,Parent=C.UIElements.Main});
				if B.Content then
					c("TextLabel", {Text=B.Content,TextSize=16,TextTransparency=0.4,TextWrapped=true,RichText=true,FontFace=Font.new(b.Font, Enum.FontWeight.Medium),TextXAlignment="Left",Size=UDim2.new(1, 0, 0, 0),AutomaticSize="Y",LayoutOrder=2,ThemeTag={TextColor3="Text"},BackgroundTransparency=1,Parent=C.UIElements.Main});
				end
				c("Frame", {Name="Line",Size=UDim2.new(1, C.UIPadding * 2, 0, 1),Parent=C.UIElements.Main,LayoutOrder=3,BackgroundTransparency=0.8,ThemeTag={BackgroundColor3="Text"}});
				local D = c("Frame", {Size=UDim2.new(1, 0, 0, 0),AutomaticSize="Y",BackgroundTransparency=1,Parent=C.UIElements.Main,LayoutOrder=4}, {c("UIListLayout", {Padding=UDim.new(0, 10),FillDirection="Horizontal",HorizontalAlignment="Center"})});
				for E, F in next, B.Buttons do
					local G = c("TextButton", {Text=(F.Title or "Button"),TextSize=14,FontFace=Font.new(b.Font, Enum.FontWeight.Medium),ThemeTag={TextColor3="Text",BackgroundColor3="Text"},BackgroundTransparency=0.93,Parent=D,Size=UDim2.new(1 / #B.Buttons, -(((#B.Buttons - 1) * 10) / #B.Buttons), 0, 0),AutomaticSize="Y"}, {c("UICorner", {CornerRadius=UDim.new(0, C.UICorner - 7)}),c("UIPadding", {PaddingTop=UDim.new(0, C.UIPadding / 1.85),PaddingLeft=UDim.new(0, C.UIPadding / 1.85),PaddingRight=UDim.new(0, C.UIPadding / 1.85),PaddingBottom=UDim.new(0, C.UIPadding / 1.85)}),c("Frame", {Size=UDim2.new(1, (C.UIPadding / 1.85) * 2, 1, (C.UIPadding / 1.85) * 2),Position=UDim2.new(0.5, 0, 0.5, 0),AnchorPoint=Vector2.new(0.5, 0.5),ThemeTag={BackgroundColor3="Text"},BackgroundTransparency=1}, {c("UICorner", {CornerRadius=UDim.new(0, C.UICorner - 7)})})});
					G.MouseEnter:Connect(function()
						d(G.Frame, 0.1, {BackgroundTransparency=0.9}):Play();
					end);
					G.MouseLeave:Connect(function()
						d(G.Frame, 0.1, {BackgroundTransparency=1}):Play();
					end);
					G.MouseButton1Click:Connect(function()
						C:Close();
						task.spawn(function()
							pcall(F.Callback);
						end);
					end);
				end
				return C;
			end;
			local z = g({Title="Warning",Content="Do you want to close this window?",Buttons={{Title="No",Callback=function()
			end},{Title="Yes",Callback=function()
				g:Close():Destroy();
			end}}});
			p.MouseButton1Click:Connect(function()
				z:Open();
			end);
			local A = function(A)
				isResizing = true;
				k.Active = true;
				initialSize = g.UIElements.Main.Size;
				initialInputPosition = A.Position;
				d(k, 0.2, {BackgroundTransparency=0.65}):Play();
				d(k.ImageLabel, 0.2, {ImageTransparency=0}):Play();
				A.Changed:Connect(function()
					if (A.UserInputState == Enum.UserInputState.End) then
						isResizing = false;
						k.Active = false;
						d(k, 0.2, {BackgroundTransparency=1}):Play();
						d(k.ImageLabel, 0.2, {ImageTransparency=1}):Play();
					end
				end);
			end;
			j.InputBegan:Connect(function(B)
				if ((B.UserInputType == Enum.UserInputType.MouseButton1) or (B.UserInputType == Enum.UserInputType.Touch)) then
					A(B);
				end
			end);
			aa.InputChanged:Connect(function(B)
				if isResizing then
					if ((B.UserInputType == Enum.UserInputType.MouseMovement) or (B.UserInputType == Enum.UserInputType.Touch)) then
						local C = B.Position - initialInputPosition;
						local D = UDim2.new(0, initialSize.X.Offset + (C.X * 2), 0, initialSize.Y.Offset + (C.Y * 2));
						d(g.UIElements.Main, 0.06, {Size=UDim2.new(0, math.clamp(D.X.Offset, 400, 700), 0, math.clamp(D.Y.Offset, 350, 520))}):Play();
					end
				end
			end);
			return g;
		end;
	end;
end
local aa, ab, b, c = {Window=nil,Theme=nil,Themes=nil,Transparent=false}, game:GetService("RunService"), a.load("d"), a.load("f");
local d, e = c.New, c.Tween;
aa.Themes = b;
local f = protectgui or (syn and syn.protect_gui) or function()
end;
aa.ScreenGui = d("ScreenGui", {Name="WindUI",Parent=((ab:IsStudio() and LocalPlayer.PlayerGui) or game:GetService("CoreGui")),IgnoreGuiInset=true}, {d("Folder", {Name="Window"}),d("Folder", {Name="Notifications"}),d("Folder", {Name="Dropdowns"}),d("Folder", {Name="KeySystem"})});
f(aa.ScreenGui);
local g = a.load("g");
local h = g.Init(aa.ScreenGui.Notifications);
aa.Notify = function(i, j)
	return g.New({Title=j.Title,Content=j.Content,Duration=j.Duration,CanClose=j.CanClose,Callback=j.Callback,Window=aa.Window,Holder=h});
end;
aa.CreateWindow = function(i, j)
	local k = a.load("s");
	if aa.Window then
		warn("You cannot create more than one window");
		return;
	end
	local l, o = true, b[j.Theme or "Dark"];
	aa.Theme = o;
	c.SetTheme(o);
	function KeySystem()
		l = false;
		local p = a.load("o").Init(aa.ScreenGui.KeySystem);
		local q = p.Create(true);
		local r = d("ImageLabel", {Image="rbxassetid://8992230677",ImageColor3=Color3.new(0, 0, 0),ImageTransparency=0.7,Size=UDim2.new(0, 120, 0, 116),Position=UDim2.new(0.5, 0, 0.5, 0),AnchorPoint=Vector2.new(0.5, 0.5),ScaleType="Slice",SliceCenter=Rect.new(99, 99, 99, 99),BackgroundTransparency=1,ZIndex=-1,Parent=q.UIElements.Main.Parent});
		q.UIElements.Main:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			r.Size = UDim2.new(0, q.UIElements.Main.AbsoluteSize.X + 120, 0, q.UIElements.Main.AbsoluteSize.Y + 116);
		end);
		local s, t = d("ImageButton", {Size=UDim2.new(0, 22, 0, 22),Image=c.Icon("x"),BackgroundTransparency=1,AnchorPoint=Vector2.new(1, 0),Position=UDim2.new(1, 0, 0, 0),Parent=q.UIElements.Main}), d("Frame", {Size=UDim2.new(0, 0, 0, 0),AutomaticSize="XY",BackgroundTransparency=1,Parent=q.UIElements.Main});
		d("UIListLayout", {Padding=UDim.new(0, 14.4),FillDirection="Vertical",Parent=t});
		d("UISizeConstraint", {MinSize=Vector2.new(50, 20),MaxSize=Vector2.new(620, math.huge),Parent=t});
		local u, v, w = d("TextLabel", {Text="Key System",TextSize=20,FontFace=Font.new(c.Font, Enum.FontWeight.SemiBold),TextXAlignment="Left",TextWrapped=false,Size=UDim2.new(0, 0, 0, 0),AutomaticSize="XY",ThemeTag={TextColor3="Text"},BackgroundTransparency=1}), d("UIListLayout", {Padding=UDim.new(0, 8),FillDirection="Horizontal",VerticalAlignment="Bottom"}), d("TextLabel", {Text=(j.Title or "UI Library"),TextSize=16,FontFace=Font.new(c.Font, Enum.FontWeight.Medium),TextXAlignment="Left",TextWrapped=false,Size=UDim2.new(0, 0, 0, 0),AutomaticSize="XY",TextTransparency=0.4,ThemeTag={TextColor3="Text"},BackgroundTransparency=1});
		d("Frame", {Parent=t,AutomaticSize="XY",BackgroundTransparency=1}, {u,w,v});
		if j.KeySystem.Note then
			d("TextLabel", {Text=("Note:\n" .. j.KeySystem.Note),TextSize=15,RichText=true,LayoutOrder=3,TextTransparency=0.4,TextWrapped=true,FontFace=Font.new(c.Font, Enum.FontWeight.Medium),TextXAlignment="Left",Size=UDim2.new(0, 320, 0, 0),AutomaticSize="Y",LayoutOrder=2,TextYAlignment="Top",ThemeTag={TextColor3="Text"},BackgroundTransparency=1,Parent=t});
		end
		local x = d("Frame", {Size=UDim2.new(0, 0, 0, 35),AutomaticSize="X",LayoutOrder=1,BackgroundTransparency=1,Parent=t}, {d("UIListLayout", {Padding=UDim.new(0, 10),FillDirection="Horizontal",VerticalAlignment="Center"}),d("Frame", {BackgroundTransparency=0.95,Size=UDim2.new(0, 180, 0, 35),AnchorPoint=Vector2.new(1, 0.5),Position=UDim2.new(1, 0, 0.5, 0),ThemeTag={BackgroundColor3="Text"},ZIndex=2}, {d("TextBox", {MultiLine=false,Size=UDim2.new(1, 0, 0, 0),AutomaticSize="Y",BackgroundTransparency=1,Position=UDim2.new(0, 0, 0.5, 0),AnchorPoint=Vector2.new(0, 0.5),ClearTextOnFocus=false,Text="",TextSize=15,ClipsDescendants=true,TextXAlignment="Left",FontFace=Font.new(c.Font),PlaceholderText="Enter Key...",ThemeTag={TextColor3="Text"}}),d("UICorner", {CornerRadius=UDim.new(0, 8)}),d("UIStroke", {ThemeTag={Color="Text"},Transparency=0.93,ApplyStrokeMode="Border",Thickness=1}),d("UIPadding", {PaddingTop=UDim.new(0, 12),PaddingLeft=UDim.new(0, 12),PaddingRight=UDim.new(0, 12),PaddingBottom=UDim.new(0, 12)})})});
		local y, z = (d("TextButton", {Text="Submit",TextSize=15,FontFace=Font.new(c.Font, Enum.FontWeight.Medium),ThemeTag={TextColor3="Text",BackgroundColor3="Text"},BackgroundTransparency=0.9,Parent=x,Size=UDim2.new(0, 0, 0, 35),AutomaticSize="X"}, {d("UICorner", {CornerRadius=UDim.new(0, 8)}),d("UIPadding", {PaddingTop=UDim.new(0, 14),PaddingLeft=UDim.new(0, 14),PaddingRight=UDim.new(0, 14),PaddingBottom=UDim.new(0, 14)}),d("Frame", {Size=UDim2.new(1, 28, 1, 28),Position=UDim2.new(0.5, 0, 0.5, 0),AnchorPoint=Vector2.new(0.5, 0.5),ThemeTag={BackgroundColor3="Text"},BackgroundTransparency=1}, {d("UICorner", {CornerRadius=UDim.new(0, 8)})})}));
		if j.KeySystem.URL then
			z = d("TextButton", {Text="Get Key",TextSize=15,FontFace=Font.new(c.Font, Enum.FontWeight.Medium),ThemeTag={TextColor3="Text",BackgroundColor3="Text"},BackgroundTransparency=0.9,Parent=x,Size=UDim2.new(0, 0, 0, 35),AutomaticSize="X"}, {d("UICorner", {CornerRadius=UDim.new(0, 8)}),d("Frame", {Size=UDim2.new(1, 28, 1, 28),Position=UDim2.new(0.5, 0, 0.5, 0),AnchorPoint=Vector2.new(0.5, 0.5),ThemeTag={BackgroundColor3="Text"},BackgroundTransparency=1}, {d("UICorner", {CornerRadius=UDim.new(0, 8)})}),d("UIPadding", {PaddingTop=UDim.new(0, 14),PaddingLeft=UDim.new(0, 14),PaddingRight=UDim.new(0, 14),PaddingBottom=UDim.new(0, 14)})});
		end
		if (j.KeySystem.SaveKey and j.Folder) then
			d("TextLabel", {Text=("Your key will be saved in Workspace/" .. j.Folder .. "/" .. game.Players.LocalPlayer.Name .. ".key"),TextSize=13,FontFace=Font.new(c.Font, Enum.FontWeight.SemiBold),TextXAlignment="Left",TextWrapped=false,LayoutOrder=99,Parent=t,Size=UDim2.new(0, 0, 0, 0),AutomaticSize="XY",TextTransparency=0.4,ThemeTag={TextColor3="Text"},BackgroundTransparency=1});
		end
		y.MouseEnter:Connect(function()
			e(y.Frame, 0.1, {BackgroundTransparency=0.9}):Play();
		end);
		y.MouseLeave:Connect(function()
			e(y.Frame, 0.1, {BackgroundTransparency=1}):Play();
		end);
		y.MouseButton1Click:Connect(function()
			local A = x.Frame.TextBox.Text;
			if (A and (A == j.KeySystem.Key)) then
				q:Close();
				e(r, 0.1, {ImageTransparency=1}):Play();
				l = true;
				if (j.KeySystem.SaveKey and j.Folder) then
					writefile(j.Folder .. "/" .. game.Players.LocalPlayer.Name .. ".key", tostring(A));
				end
				task.spawn(function()
					task.wait(0.1);
					r:Destroy();
				end);
			end
		end);
		if j.KeySystem.URL then
			z.MouseEnter:Connect(function()
				e(z.Frame, 0.1, {BackgroundTransparency=0.9}):Play();
			end);
			z.MouseLeave:Connect(function()
				e(z.Frame, 0.1, {BackgroundTransparency=1}):Play();
			end);
			z.MouseButton1Click:Connect(function()
				setclipboard(j.KeySystem.URL);
				z.Text = "Copied!";
				task.wait(3);
				z.Text = "Get Key";
			end);
		end
		s.MouseButton1Click:Connect(function()
			q:Close();
			e(r, 0.1, {ImageTransparency=1}):Play();
			task.spawn(function()
				task.wait(0.1);
				r:Destroy();
			end);
		end);
	end
	if j.KeySystem then
		if j.KeySystem.SaveKey then
			if (isfile(j.Folder .. "/" .. game.Players.LocalPlayer.Name .. ".key") and (j.KeySystem.Key == readfile(j.Folder .. "/" .. game.Players.LocalPlayer.Name .. ".key"))) then
				l = true;
			else
				KeySystem();
			end
		else
			KeySystem();
		end
		repeat
			task.wait();
		until l 
	end
	local p = k({Title=j.Title,Author=j.Author,Size=j.Size,Transparent=j.Transparent,Icon=j.Icon,Folder=j.Folder,HasOutline=j.HasOutline,Theme=o,WindUI=aa,Parent=aa.ScreenGui.Window,SideBarWidth=j.SideBarWidth});
	aa.Transparent = j.Transparent;
	aa.Window = p;
	p.AddTheme = function(q, r)
		b[r.Name] = r;
		return r;
	end;
	p.SetTheme = function(q, r)
		if b[r] then
			aa.Theme = b[r];
			c.SetTheme(b[r]);
			c.UpdateTheme();
			return b[r];
		end
		return nil;
	end;
	p.GetThemes = function(q)
		return b;
	end;
	p.GetCurrentTheme = function(q)
		return aa.Theme.Name;
	end;
	p.GetTransparency = function(q)
		return aa.Transparent or false;
	end;
	p.GetWindowSize = function(q)
		return p.UIElements.Main.Size;
	end;
	p.ToggleTransparency = function(q, r)
		aa.Transparent = r;
		p.UIElements.Main.Background.BackgroundTransparency = (r and 0.15) or 0;
		p.UIElements.Main.Gradient.UIGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1),NumberSequenceKeypoint.new(1, (r and 0.85) or 0.7)});
	end;
	return p;
end;
return aa;
