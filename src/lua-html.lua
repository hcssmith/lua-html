local html_tags = {
	"a",
	"abbr",
	"acronym",
	"address",
	"applet",
	"area",
	"article",
	"aside",
	"audio",
	"b",
	"base",
	"basefont",
	"bdi",
	"bdo",
	"big",
	"blockquote",
	"body",
	"br",
	"button",
	"canvas",
	"caption",
	"center",
	"cite",
	"code",
	"col",
	"colgroup",
	"data",
	"datalist",
	"dd",
	"del",
	"details",
	"dfn",
	"dialog",
	"dir",
	"div",
	"dl",
	"dt",
	"em",
	"embed",
	"fieldset",
	"figcaption",
	"figure",
	"font",
	"footer",
	"form",
	"frame",
	"frameset",
	"h1",
	"h2",
	"h3",
	"h4",
	"h5",
	"h6",
	"head",
	"header",
	"hgroup",
	"hr",
	"html",
	"i",
	"iframe",
	"img",
	"input",
	"ins",
	"kbd",
	"label",
	"legend",
	"li",
	"link",
	"main",
	"map",
	"mark",
	"menu",
	"meta",
	"meter",
	"nav",
	"noframes",
	"noscript",
	"object",
	"ol",
	"optgroup",
	"option",
	"output",
	"p",
	"param",
	"picture",
	"pre",
	"progress",
	"q",
	"rp",
	"rt",
	"ruby",
	"s",
	"samp",
	"script",
	"search",
	"section",
	"select",
	"small",
	"source",
	"span",
	"strike",
	"strong",
	"style",
	"sub",
	"summary",
	"sup",
	"svg",
	"table",
	"tbody",
	"td",
	"template",
	"textarea",
	"tfoot",
	"th",
	"thead",
	"time",
	"title",
	"tr",
	"track",
	"tt",
	"u",
	"ul",
	"var",
	"video",
	"wbr",
}

---@alias HTMLTagFunc fun(spec: spec): Element

---@class HTMLTags
---@field a HTMLTagFunc
---@field abbr HTMLTagFunc
---@field acronym HTMLTagFunc
---@field address HTMLTagFunc
---@field applet HTMLTagFunc
---@field area HTMLTagFunc
---@field article HTMLTagFunc
---@field aside HTMLTagFunc
---@field audio HTMLTagFunc
---@field b HTMLTagFunc
---@field base HTMLTagFunc
---@field basefont HTMLTagFunc
---@field bdi HTMLTagFunc
---@field bdo HTMLTagFunc
---@field big HTMLTagFunc
---@field blockquote HTMLTagFunc
---@field body HTMLTagFunc
---@field br HTMLTagFunc
---@field button HTMLTagFunc
---@field canvas HTMLTagFunc
---@field caption HTMLTagFunc
---@field center HTMLTagFunc
---@field cite HTMLTagFunc
---@field code HTMLTagFunc
---@field col HTMLTagFunc
---@field colgroup HTMLTagFunc
---@field data HTMLTagFunc
---@field datalist HTMLTagFunc
---@field dd HTMLTagFunc
---@field del HTMLTagFunc
---@field details HTMLTagFunc
---@field dfn HTMLTagFunc
---@field dialog HTMLTagFunc
---@field dir HTMLTagFunc
---@field div HTMLTagFunc
---@field dl HTMLTagFunc
---@field dt HTMLTagFunc
---@field em HTMLTagFunc
---@field embed HTMLTagFunc
---@field fieldset HTMLTagFunc
---@field figcaption HTMLTagFunc
---@field figure HTMLTagFunc
---@field font HTMLTagFunc
---@field footer HTMLTagFunc
---@field form HTMLTagFunc
---@field frame HTMLTagFunc
---@field frameset HTMLTagFunc
---@field h1 HTMLTagFunc
---@field h2 HTMLTagFunc
---@field h3 HTMLTagFunc
---@field h4 HTMLTagFunc
---@field h5 HTMLTagFunc
---@field h6 HTMLTagFunc
---@field head HTMLTagFunc
---@field header HTMLTagFunc
---@field hgroup HTMLTagFunc
---@field hr HTMLTagFunc
---@field html HTMLTagFunc
---@field i HTMLTagFunc
---@field iframe HTMLTagFunc
---@field img HTMLTagFunc
---@field input HTMLTagFunc
---@field ins HTMLTagFunc
---@field kbd HTMLTagFunc
---@field label HTMLTagFunc
---@field legend HTMLTagFunc
---@field li HTMLTagFunc
---@field link HTMLTagFunc
---@field main HTMLTagFunc
---@field map HTMLTagFunc
---@field mark HTMLTagFunc
---@field menu HTMLTagFunc
---@field meta HTMLTagFunc
---@field meter HTMLTagFunc
---@field nav HTMLTagFunc
---@field noframes HTMLTagFunc
---@field noscript HTMLTagFunc
---@field object HTMLTagFunc
---@field ol HTMLTagFunc
---@field optgroup HTMLTagFunc
---@field option HTMLTagFunc
---@field output HTMLTagFunc
---@field p HTMLTagFunc
---@field param HTMLTagFunc
---@field picture HTMLTagFunc
---@field pre HTMLTagFunc
---@field progress HTMLTagFunc
---@field q HTMLTagFunc
---@field rp HTMLTagFunc
---@field rt HTMLTagFunc
---@field ruby HTMLTagFunc
---@field s HTMLTagFunc
---@field samp HTMLTagFunc
---@field script HTMLTagFunc
---@field search HTMLTagFunc
---@field section HTMLTagFunc
---@field select HTMLTagFunc
---@field small HTMLTagFunc
---@field source HTMLTagFunc
---@field span HTMLTagFunc
---@field strike HTMLTagFunc
---@field strong HTMLTagFunc
---@field style HTMLTagFunc
---@field sub HTMLTagFunc
---@field summary HTMLTagFunc
---@field sup HTMLTagFunc
---@field svg HTMLTagFunc
---@field table HTMLTagFunc
---@field tbody HTMLTagFunc
---@field td HTMLTagFunc
---@field template HTMLTagFunc
---@field textarea HTMLTagFunc
---@field tfoot HTMLTagFunc
---@field th HTMLTagFunc
---@field thead HTMLTagFunc
---@field time HTMLTagFunc
---@field title HTMLTagFunc
---@field tr HTMLTagFunc
---@field track HTMLTagFunc
---@field tt HTMLTagFunc
---@field u HTMLTagFunc
---@field ul HTMLTagFunc
---@field var HTMLTagFunc
---@field video HTMLTagFunc
---@field wbr HTMLTagFunc

---@type HTMLTags
M = {}

---@class Element
---@field package _isElement boolean is this an instance of an element.
---@field package name string Name of the element
---@field package attributes table<string, string> A dictionary of element attributes.
---@field package self_closing boolean Is this a self closing tag.
---@field package children Element[] List of children of the element
---@field package text string Elements text content
---@field render fun(ElementTree): string Render the tree into a string.

---@class spec
---@field name string?
---@field text string?
---@field self_closing boolean?

--- Element constructor
---@param spec spec
---@return Element
local element = function(spec)
	---@param e Element
	local function render(e)
		local out = "<" .. e.name
		for attr, value in pairs(e.attributes) do
			out = out .. " " .. attr .. " = \"" .. value .. "\""
		end
		if e.self_closing then
			out = out .. " />"
			return out
		end
		out = out .. ">"
		--- if no children add e.text
		if #e.children > 0 then
			for _, child in pairs(e.children) do
				out = out .. child:render()
			end
		else
			out = out .. e.text
		end
		out = out .. "</" .. e.name .. ">"
		return out
	end

	---@type Element[]
	local children = {}
	for _, v in ipairs(spec) do
		---@type Element
		local item = v
		if type(item) == "table" and item._isElement == true then
			table.insert(children, item)
		end
	end

	---@type table<string, string>
	local attributes = {}

	---@param set string[]
	---@return table<string, boolean>
	local function rset(set)
		local r = {}
		for _, v in ipairs(set) do r[v] = true end
		return r
	end

	local restricted_names = rset { "name", "text", "self_closing" }
	for k, v in pairs(spec) do
		if not restricted_names[k] and type(v) == "string" then attributes[k] = v end
	end


	---@type Element
	return {
		_isElement   = true,
		name         = spec.name or "",
		self_closing = spec.self_closing or false,
		text         = spec.text or "",
		children     = children,
		attributes   = attributes,
		render       = render
	}
end
for _, v in ipairs(html_tags) do
	M[v] = function(spec)
		---@param set string[]
		---@return table<string, boolean>
		local function rset(set)
			local r = {}
			for _, elem in ipairs(set) do r[elem] = true end
			return r
		end
		local self_closing_tags = rset { "area", "base", "br", "col", "embed", "hr", "img", "input", "link", "meta", "param", "source", "track", "wbr" }
		if self_closing_tags[v] then
			spec.self_closing = true
		end
		spec.name = v
		return element(spec)
	end
end


return M
