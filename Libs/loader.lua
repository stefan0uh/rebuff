Loader = {}

local module = {}

local modules = {}

function Loader:CreateBlankModule()
    local ret = {} -- todo: copy class template
    ret.private = {} -- todo: copy class template
    return ret
end

function Loader:CreateModule(name)
  if (not modules[name]) then
    modules[name] = Loader:CreateBlankModule()
    return modules[name]
  else
    return modules[name]
  end
end

function Loader:ImportModule(name)
  if (not modules[name]) then
    modules[name] = Loader:CreateBlankModule()
    return modules[name]
  else
    return modules[name]
  end
end