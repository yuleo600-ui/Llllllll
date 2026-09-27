local builderSans, builderSansBold, tweenTo, getGlobal, bindFocusEffects, safeCall, rgbToHex, addCorner, addPadding, createLabel, ensureTable, roundToStep, formatNumber, resolveColor, colorToRgbTable, createTextContainer, fitTextSize, keyCodeToLabel, getCamera, normalizeKeyCode, userInputService, tweenService, players, coreGui, httpService, textService, runService, Library, Themes, Theme, FontSizes, getThemeColor, getGuiParent, createInstance, createButton, clearThemeGradient, isMobile, createSliderTrack

userInputService = (game:GetService("UserInputService"))

tweenService = (game:GetService("TweenService"))

players = (game:GetService("Players"))

-- [Zaka 补丁 1] CoreGui 不能在加载期硬读: 手机执行器常无权访问, 一报错整个库就死在 pcall 里
coreGui = (function()
  local ok, svc = pcall(function()
    return game:GetService("CoreGui")
  end)
  if ok and svc then
    return svc
  end
  return nil
end)()

httpService = (game:GetService("HttpService"))

textService = (game:GetService("TextService"))

runService = (game:GetService("RunService"))

Library = {}
Library.__index = Library
Library.Version = "6.8.12"
Library._windows = {}

Themes = {
  Aubergine = {
    Name = "Aubergine",
    Primary = (Color3.fromRGB(94, 92, 230)),
    Accent = (Color3.fromRGB(191, 90, 242)),
  },
  Aqua = {
    Name = "Aqua",
    Primary = (Color3.fromRGB(64, 203, 224)),
    Accent = (Color3.fromRGB(100, 210, 255)),
  },
  Banana = {
    Name = "Banana",
    Primary = (Color3.fromRGB(255, 214, 10)),
    Accent = (Color3.fromRGB(255, 159, 10)),
  },
  Blend = {
    Name = "Blend",
    Primary = (Color3.fromRGB(10, 132, 255)),
    Accent = (Color3.fromRGB(100, 210, 255)),
  },
  Blossom = {
    Name = "Blossom",
    Primary = (Color3.fromRGB(255, 55, 95)),
    Accent = (Color3.fromRGB(255, 100, 130)),
  },
  Bubblegum = {
    Name = "Bubblegum",
    Primary = (Color3.fromRGB(255, 45, 85)),
    Accent = (Color3.fromRGB(191, 90, 242)),
  },
  ["Candy Cane"] = {
    Name = "Candy Cane",
    Primary = (Color3.fromRGB(255, 69, 58)),
    Accent = (Color3.fromRGB(255, 105, 97)),
  },
  Cherry = {
    Name = "Cherry",
    Primary = (Color3.fromRGB(255, 59, 48)),
    Accent = (Color3.fromRGB(255, 105, 97)),
  },
  Christmas = {
    Name = "Christmas",
    Primary = (Color3.fromRGB(255, 69, 58)),
    Accent = (Color3.fromRGB(48, 209, 88)),
  },
  Coral = {
    Name = "Coral",
    Primary = (Color3.fromRGB(255, 69, 58)),
    Accent = (Color3.fromRGB(255, 159, 10)),
  },
  ["Digital Horizon"] = {
    Name = "Digital Horizon",
    Primary = (Color3.fromRGB(50, 173, 230)),
    Accent = (Color3.fromRGB(100, 210, 255)),
  },
  Express = {
    Name = "Express",
    Primary = (Color3.fromRGB(255, 159, 10)),
    Accent = (Color3.fromRGB(255, 214, 10)),
  },
  ["Lime Water"] = {
    Name = "Lime Water",
    Primary = (Color3.fromRGB(48, 209, 88)),
    Accent = (Color3.fromRGB(165, 243, 252)),
  },
  Lush = {
    Name = "Lush",
    Primary = (Color3.fromRGB(48, 209, 88)),
    Accent = (Color3.fromRGB(102, 212, 207)),
  },
  Halogen = {
    Name = "Halogen",
    Primary = (Color3.fromRGB(100, 210, 255)),
    Accent = (Color3.fromRGB(165, 243, 252)),
  },
  Hyper = {
    Name = "Hyper",
    Primary = (Color3.fromRGB(255, 55, 95)),
    Accent = (Color3.fromRGB(191, 90, 242)),
  },
  Magic = {
    Name = "Magic",
    Primary = (Color3.fromRGB(191, 90, 242)),
    Accent = (Color3.fromRGB(94, 92, 230)),
  },
  May = {
    Name = "May",
    Primary = (Color3.fromRGB(48, 209, 88)),
    Accent = (Color3.fromRGB(102, 212, 207)),
  },
  ["Orange Juice"] = {
    Name = "Orange Juice",
    Primary = (Color3.fromRGB(255, 159, 10)),
    Accent = (Color3.fromRGB(255, 214, 10)),
  },
  Pastel = {
    Name = "Pastel",
    Primary = (Color3.fromRGB(0, 168, 255)),
    Accent = (Color3.fromRGB(0, 229, 255)),
  },
  Pumpkin = {
    Name = "Pumpkin",
    Primary = (Color3.fromRGB(255, 149, 0)),
    Accent = (Color3.fromRGB(255, 214, 10)),
  },
  Satin = {
    Name = "Satin",
    Primary = (Color3.fromRGB(191, 90, 242)),
    Accent = (Color3.fromRGB(255, 100, 130)),
  },
  ["Snowy Sky"] = {
    Name = "Snowy Sky",
    Primary = (Color3.fromRGB(100, 185, 255)),
    Accent = (Color3.fromRGB(165, 220, 255)),
  },
  ["Steel Fade"] = {
    Name = "Steel Fade",
    Primary = (Color3.fromRGB(142, 142, 147)),
    Accent = (Color3.fromRGB(174, 174, 178)),
  },
  Sundae = {
    Name = "Sundae",
    Primary = (Color3.fromRGB(255, 159, 10)),
    Accent = (Color3.fromRGB(255, 100, 130)),
  },
  Sunkist = {
    Name = "Sunkist",
    Primary = (Color3.fromRGB(255, 120, 0)),
    Accent = (Color3.fromRGB(255, 193, 7)),
  },
  Water = {
    Name = "Water",
    Primary = (Color3.fromRGB(10, 132, 255)),
    Accent = (Color3.fromRGB(100, 210, 255)),
  },
  Legacy = {
    Name = "Legacy",
    Primary = (Color3.fromRGB(0, 120, 255)),
    Accent = (Color3.fromRGB(0, 200, 255)),
  },
  Winter = {
    Name = "Winter",
    Primary = (Color3.fromRGB(100, 210, 255)),
    Accent = (Color3.fromRGB(165, 220, 255)),
  },
  Peony = {
    Name = "Peony",
    Primary = (Color3.fromRGB(255, 55, 95)),
    Accent = (Color3.fromRGB(255, 100, 130)),
  },
  Shadow = {
    Name = "Shadow",
    Primary = (Color3.fromRGB(90, 90, 95)),
    Accent = (Color3.fromRGB(142, 142, 147)),
  },
  Wood = {
    Name = "Wood",
    Primary = (Color3.fromRGB(161, 122, 90)),
    Accent = (Color3.fromRGB(188, 148, 116)),
  },
  Creida = {
    Name = "Creida",
    Primary = (Color3.fromRGB(255, 90, 40)),
    Accent = (Color3.fromRGB(255, 159, 10)),
  },
  ["Creida Two"] = {
    Name = "Creida Two",
    Primary = (Color3.fromRGB(64, 203, 224)),
    Accent = (Color3.fromRGB(100, 210, 255)),
  },
  Gothic = {
    Name = "Gothic",
    Primary = (Color3.fromRGB(94, 92, 230)),
    Accent = (Color3.fromRGB(191, 90, 242)),
  },
  Rue = {
    Name = "Rue",
    Primary = (Color3.fromRGB(191, 90, 242)),
    Accent = (Color3.fromRGB(255, 100, 130)),
  },
  Purple = {
    Name = "Purple",
    Primary = (Color3.fromRGB(191, 90, 242)),
    Accent = (Color3.fromRGB(94, 92, 230)),
  },
  Rainbow = {
    Name = "Rainbow",
    Primary = (Color3.fromRGB(255, 55, 95)),
    Accent = (Color3.fromRGB(10, 132, 255)),
  },
  Nord = {
    Name = "Nord",
    Primary = (Color3.fromRGB(110, 170, 205)),
    Accent = (Color3.fromRGB(80, 120, 165)),
  },
}

Theme = {
  Bg = (Color3.fromRGB(6, 6, 8)),
  Window = (Color3.fromRGB(16, 16, 19)),
  Sidebar = (Color3.fromRGB(20, 20, 24)),
  Content = (Color3.fromRGB(18, 18, 22)),
  Card = (Color3.fromRGB(26, 26, 31)),
  CardHover = (Color3.fromRGB(35, 35, 42)),
  Track = (Color3.fromRGB(33, 33, 39)),
  TrackHover = (Color3.fromRGB(42, 42, 50)),
  Line = (Color3.fromRGB(45, 45, 52)),
  Text = (Color3.fromRGB(255, 255, 255)),
  SubText = (Color3.fromRGB(158, 158, 166)),
  Muted = (Color3.fromRGB(99, 99, 107)),
  Border = (Color3.fromRGB(48, 48, 55)),
}

FontSizes = {
  Default = 14,
  WindowTitle = 21,
  VersionLabel = 13,
  CreditLabel = 11,
  NavLabel = 15,
  SearchBox = 16,
  InfoCard = 13,
  NotificationTitle = 14,
  NotificationBody = 12,
  ThemeName = { 13, 12 },
  ActiveBadge = 11,
  ModuleTitle = 16,
  CategoryLabel = 12,
  Description = 13,
  GearIcon = 16,
  ControlText = 14,
  InputBox = 12,
  KeybindBox = 12,
  ValueBox = 14,
  HexLabel = 11,
  PlayerName = { 13, 11 },
  PlayerActionButton = { 11, 10 },
  PlayerSearchBox = 13,
  ConfigTitle = 15,
  ConfigInput = 13,
  ConfigButton = 12,
  Toast = 14,
}

Library.FontSizes = FontSizes

function getThemeColor(themeName, colorKey)
  local value = FontSizes[themeName]

  if (type(value)) == "table" then
    local colorKey2 = colorKey

    if colorKey then

      colorKey2 = value[2] or value[1]
    end

    return colorKey2 or value[1]
  else

    return value or FontSizes.Default
  end
end

builderSans = Enum.Font.BuilderSans or Enum.Font.SourceSans

builderSansBold = Enum.Font.BuilderSansBold or Enum.Font.SourceSansBold

function tweenTo(target, duration, properties)

  local create = tweenService:Create(target, (TweenInfo.new(
    properties or 0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out
  )), duration)

  create:Play()

  return create
end

function getGlobal(name)

  local g = getgenv and getgenv() or _G

  return g and g[name] or nil
end

function bindFocusEffects(frame, callback)
  local focused = frame.Focused

  focused:Connect(function()
    frame.BackgroundTransparency = 0.92
    frame.BorderSizePixel = 1
    return
  end)

  frame.FocusLost:Connect(function()
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0

    callback(frame.Text)
    return
  end)

  return
end

function safeCall(fn, ...)

  if fn then
    local tbl = { pcall(fn, ...) }

    local value = tbl[2]

    if not tbl[1] then
      error(value)
    end
  end

  return
end

function getGuiParent()
  local gethui = getGlobal("gethui")
  local localPlayer

  if (typeof(gethui)) == "function" then
    local huiResult, huiOk
    huiOk, huiResult = pcall(gethui)

    if huiOk and huiResult then
      return huiResult
    else
      localPlayer = players.LocalPlayer

      if localPlayer then
        local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")

        if playerGui then
          return playerGui
        else
          return coreGui
        end
      else

        return coreGui
      end
    end
  else

    localPlayer = players.LocalPlayer

    if localPlayer then
      local playerGui = localPlayer:FindFirstChildOfClass("PlayerGui")

      if playerGui then
        return playerGui
      else
        return coreGui
      end
    else

      return coreGui
    end
  end
end

-- [Zaka 补丁 2] 重写 GUI 父级: 永不返回 CoreGui (普通身份写 CoreGui 必报错, UI 直接不显示)
getGuiParent = function()
  local hui = nil
  pcall(function()
    local g = getGlobal("gethui")
    if type(g) == "function" then
      hui = g()
    end
  end)
  if hui then
    return hui
  end

  local lp = players.LocalPlayer
  if not lp then
    pcall(function()
      lp = game:GetService("Players").LocalPlayer
    end)
  end

  if lp then
    local pg = lp:FindFirstChildOfClass("PlayerGui")
    if not pg then
      pcall(function()
        pg = lp:WaitForChild("PlayerGui", 8)
      end)
    end
    if pg then
      return pg
    end
  end

  pcall(function()
    warn("[Zaka Hub] 找不到 PlayerGui, UI 可能无法显示")
  end)
  return nil
end

function rgbToHex(color)

  return string.format(
    "#%02X%02X%02X", (math.floor(color.R * 255 + 0.5)), (math.floor(color.G * 255 + 0.5)),
    math.floor(color.B * 255 + 0.5)
  )
end

function addCorner(radius)
  return createInstance("UICorner", { CornerRadius = (UDim.new(0, radius)) })
end

function addPadding(left, right, top, bottom)
  return createInstance("UIPadding", {
    PaddingLeft = (UDim.new(0, left or 0)),
    PaddingTop = (UDim.new(0, right or 0)),
    PaddingRight = (UDim.new(0, top or 0)),
    PaddingBottom = (UDim.new(0, bottom or 0)),
  })
end

createInstance = function(className, properties, parent)
  local player = properties
  local instance = Instance.new(className)

  for propName, propValue in pairs(properties or {}) do
    instance[propName] = propValue
  end

  if parent then
    for index, value in ipairs(parent) do
      value.Parent = instance
    end
  end

  return instance
end

function createLabel(parent, text, options)
  local border = parent or Theme.Border
  local createInstance2 = createInstance

  return createInstance("UIStroke", {
    Color = border,
    Transparency = text or 0,
    Thickness = options or 1,
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
  })
end

function ensureTable(value, ...)

  if (type(value)) == "table" then
    return value
  else
    local tbl = { ... }

    return {
      Name = value,
      Min = tbl[1],
      Max = tbl[2],
      Default = tbl[3],
      Callback = tbl[4],
    }
  end
end

function roundToStep(value, step)

  if step and step > 0 then
    return (math.floor(value / step + 0.5)) * step
  else
    return value
  end
end

function formatNumber(number)

  if (math.abs(number - (math.floor(number)))) < 0.001 then
    return tostring(math.floor(number))
  else
    return string.format("%.1f", number)
  end
end

function resolveColor(colorValue, fallback)
  local resolvedColor

  if (typeof(colorValue)) == "Color3" then
    return colorValue
  else
    if (type(colorValue)) == "table" then

      local r = colorValue.R

      local r2 = r

      if not r then

        r2 = colorValue.r or colorValue[1]
      end

      local result = tonumber(r2)

      local tonumber2 = tonumber

      local g2 = colorValue.G

      local g3 = g2

      if not g2 then

        g3 = colorValue.g or colorValue[2]
      end

      local result2 = tonumber2(g3)

      local tonumber3 = tonumber

      local b = colorValue.B

      local b2 = b

      if not b then

        b2 = colorValue.b or colorValue[3]
      end

      local result3 = tonumber3(b2)

      local colorOk = result

      if result then

        colorOk = result2 and result3
      end

      if colorOk then
        local value = result <= 1

        local colorValue = value

        if value then

          colorValue = result2 <= 1 and result3 <= 1
        end

        if colorValue then
          return Color3.new(
            (math.clamp(result, 0, 1)), (math.clamp(result2, 0, 1)), math.clamp(result3, 0, 1)
          )
        else
          return Color3.fromRGB(
            (math.clamp(result, 0, 255)), (math.clamp(result2, 0, 255)), math.clamp(result3, 0, 255)
          )
        end
      else

        if (type(colorValue)) == "string" then
          local gsub = colorValue:gsub("#", "")

          if #gsub == 6 then
            local result7 = tonumber((gsub:sub(1, 2)), 16)

            local result8 = tonumber((gsub:sub(3, 4)), 16)

            local result9 = tonumber((gsub:sub(5, 6)), 16)

            local conditionOk = result7

            if result7 then

              conditionOk = result8 and result9
            end

            if conditionOk then
              return Color3.fromRGB(result7, result8, result9)
            else
              resolvedColor = fallback

              return fallback or Color3.fromRGB(56, 189, 248)
            end
          else

            resolvedColor = fallback

            return fallback or Color3.fromRGB(56, 189, 248)
          end
        else

          resolvedColor = fallback

          return fallback or Color3.fromRGB(56, 189, 248)
        end
      end
    else

      if (type(colorValue)) == "string" then
        local gsub = colorValue:gsub("#", "")

        if #gsub == 6 then
          local result7 = tonumber((gsub:sub(1, 2)), 16)

          local result8 = tonumber((gsub:sub(3, 4)), 16)

          local result9 = tonumber((gsub:sub(5, 6)), 16)

          local conditionOk = result7

          if result7 then

            conditionOk = result8 and result9
          end

          if conditionOk then
            return Color3.fromRGB(result7, result8, result9)
          else
            resolvedColor = fallback

            return fallback or Color3.fromRGB(56, 189, 248)
          end
        else

          resolvedColor = fallback

          return fallback or Color3.fromRGB(56, 189, 248)
        end
      else

        resolvedColor = fallback

        return fallback or Color3.fromRGB(56, 189, 248)
      end
    end
  end
end

function colorToRgbTable(color)

  return {
    R = (math.floor(color.R * 255 + 0.5)),
    G = (math.floor(color.G * 255 + 0.5)),
    B = (math.floor(color.B * 255 + 0.5)),
  }
end

function createButton(parent, text, callback, icon, options)
  local themeGradient = parent:FindFirstChild("ThemeGradient")

  if not themeGradient then

    local rotation = icon or 0

    local createInstance2 = createInstance

    local uiGradient = createInstance("UIGradient", {
      Name = "ThemeGradient",
      Rotation = rotation,
      Color = (ColorSequence.new(text, callback)),
    })

    uiGradient.Parent = parent

    if options and options._gradientInstances then
      table.insert(options._gradientInstances, uiGradient)
    end
  else
    themeGradient.Color = ColorSequence.new(text, callback)

    if icon then
      themeGradient.Rotation = icon
    end
  end

  if not (parent:IsA("TextLabel")) then
    parent.BackgroundColor3 = Color3.new(1, 1, 1)
  else
    parent.TextColor3 = Color3.new(1, 1, 1)
  end

  return
end

function clearThemeGradient(instance, keepBase)
  local themeGradient2 = instance:FindFirstChild("ThemeGradient")

  if themeGradient2 then
    themeGradient2:Destroy()
  end

  return
end

function createTextContainer(parent, text, options)

  local pcallOk1, pcallErr1 = pcall(function()
    local parent2 = parent

    local result = tostring(parent or "")
    local textService2 = textService
    return textService:GetTextSize(result, text, options, Vector2.new(1000, 100))
  end)

  if pcallOk1 and pcallErr1 then
    return pcallErr1.X
  else
    local tostring2 = tostring

    local parent3 = parent

    return #(tostring2(parent or "")) * text * 0.55
  end
end

function fitTextSize(label)

  local text = label.Text or ""
  local createInstance2 = createInstance
  local text2 = tostring(text)
  local size = label.Size
  local udim = size
  local createInstance3 = createInstance
  udim = size or UDim2.new(1, 0, 1, 0)
  local createInstance4 = createInstance
  local createInstance5 = createInstance
  local position = label.Position

  local udim2 = position
  udim2 = position or UDim2.new()

  local createInstance6 = createInstance
  local createInstance7 = createInstance

  local color = label.Color or Theme.Text
  local createInstance8 = createInstance
  local createInstance9 = createInstance

  local textSize = label.TextSize or getThemeColor("Default")
  local createInstance10 = createInstance
  local createInstance11 = createInstance

  local font = label.Font or builderSans
  local createInstance12 = createInstance
  local createInstance13 = createInstance

  local x = label.X or Enum.TextXAlignment.Left
  local createInstance14 = createInstance
  local createInstance15 = createInstance

  local y = label.Y or Enum.TextYAlignment.Center
  local createInstance16 = createInstance
  local wrapped = label.Wrapped or false
  local truncate = label.Truncate
  local createInstance17 = createInstance
  local none = truncate or Enum.TextTruncate.None
  local createInstance18 = createInstance

  return createInstance("TextLabel", {
    Text = text2,
    Size = udim,
    Position = udim2,
    BackgroundTransparency = 1,
    TextColor3 = color,
    TextSize = textSize,
    Font = font,
    TextXAlignment = x,
    TextYAlignment = y,
    TextWrapped = wrapped,
    TextTruncate = none,
    ZIndex = label.ZIndex or 1,
  })
end

function keyCodeToLabel(keyCode)

  if (typeof(keyCode)) == "EnumItem" then

    return ((keyCode.Name:gsub("Right", "R")):gsub("Left", "L"))
  else
    return "None"
  end
end

function getCamera()
  local currentCamera = workspace.CurrentCamera

  if currentCamera then
    return currentCamera.ViewportSize
  else
    return Vector2.new(800, 600)
  end
end

function normalizeKeyCode(a, b)

  if (typeof(a)) == "EnumItem" then
    return a
  else
    if (type(a)) == "string" then
      if a == "None" then
        return nil
      else
        local keyCode = Enum.KeyCode[a]

        if keyCode then
          return keyCode
        else
          local gsub2 = a:gsub("%s+", "")

          if gsub2 == "RShift" then
            return Enum.KeyCode.RightShift
          else
            if gsub2 == "LShift" then
              return Enum.KeyCode.LeftShift
            else
              if gsub2 == "RCtrl" then
                return Enum.KeyCode.RightControl
              else
                if gsub2 == "LCtrl" then
                  return Enum.KeyCode.LeftControl
                else
                  if gsub2 == "RAlt" then
                    return Enum.KeyCode.RightAlt
                  else
                    if gsub2 == "LAlt" then
                      return Enum.KeyCode.LeftAlt
                    else
                      return b
                    end
                  end
                end
              end
            end
          end
        end
      end
    else

      return b
    end
  end
end

function isMobile()
  local camera = getCamera()
  local touchEnabled = userInputService.TouchEnabled

  if touchEnabled then

    touchEnabled = not userInputService.KeyboardEnabled or camera.X <= 900
  end

  return touchEnabled
end

function createSliderTrack(parent, track, fill, options)
  local result = tonumber(parent)

  local result2 = roundToStep(result or track, options or 1)
  return math.clamp(result2, track, fill)
end

function Library.CreateWindow(self, config)
  local value = config or {}
  local configValue = value
  local mobile = value.Mobile

  if mobile == nil then
    mobile = isMobile()
  end

  local camera = getCamera()
  local value2 = mobile and (camera.X <= 560 and 142 or 176)
  local value3 = value2 or 190

  local value4 = mobile and math.min(720, math.max(360, camera.X - 24)) or 730
  local mobile2 = mobile

  local value5 = mobile and math.min(500, math.max(320, camera.Y - 24)) or 560
  local udim3 = UDim2.new(0, value4, 0, value5)
  local udim4 = UDim2.new(0.5, -(math.floor(value4 / 2)), 0.5, -(math.floor(value5 / 2)))

  local title = value.Title or "Rise"

  local version = value.Version or Library.Version

  local theme = value.Theme or "Pastel"

  local pastel = Themes[value.Theme or "Pastel"] or Themes.Pastel
  local searchTab = value.SearchTab
  local tabs = {}
  local tabOrder = {}
  local modules = {}
  local controls = {}
  local keybinds = {}
  local themeObjects = {}
  local gradientInstances = {}
  local gradientAnimation = value.GradientAnimation

  local configFolder = value.ConfigFolder or "Rise/Configs"
  local visible = value.Visible ~= false

  local Window = {
    Library = self,
    Title = title,
    Version = version,
    ThemeName = theme,
    Theme = pastel,
    SearchTab = searchTab,
    Tabs = tabs,
    TabOrder = tabOrder,
    Modules = modules,
    Controls = controls,
    Keybinds = keybinds,
    ThemeObjects = themeObjects,
    _gradientInstances = gradientInstances,
    GradientAnimation = gradientAnimation,
    ConfigFolder = configFolder,
    SearchQuery = "",
    Visible = visible,
    ShowBackdrop = value.Backdrop == true or value.ShowBackdrop == true,
    IsMobile = mobile,
    SidebarWidth = value3,
    RowHeight = mobile and 34 or 28,
    SliderHitHeight = mobile and 26 or 20,
    ToggleSize = mobile and 14 or 10,
  }

  local name = value.Name or "RiseLib"
  local guiParent = getGuiParent()
  local findFirstChild = guiParent:FindFirstChild(name)

  if findFirstChild then
    findFirstChild:Destroy()
  end

  local screenGui = createInstance("ScreenGui", {
    Name = name,
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 999,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
  })

  screenGui.Parent = guiParent

  Window.ScreenGui = screenGui

  local frame = createInstance("Frame", {
    Name = "Notifications",
    AnchorPoint = (Vector2.new(1, 1)),
    Position = (UDim2.new(1, -18, 1, -18)),
    Size = (UDim2.new(0, mobile and 260 or 310, 1, -36)),
    BackgroundTransparency = 1,
    ZIndex = 80,
  }, {
    createInstance("UIListLayout", {
      FillDirection = Enum.FillDirection.Vertical,
      SortOrder = Enum.SortOrder.LayoutOrder,
      VerticalAlignment = Enum.VerticalAlignment.Bottom,
      HorizontalAlignment = Enum.HorizontalAlignment.Right,
      Padding = (UDim.new(0, 8)),
    }),
  })

  frame.Parent = screenGui

  Window.Notifications = frame

  local frame2 = createInstance("Frame", {
    Name = "Backdrop",
    Size = (UDim2.new(1, 0, 1, 0)),
    BackgroundColor3 = Theme.Bg,
    BackgroundTransparency = Window.ShowBackdrop and 0.1 or 1,
    BorderSizePixel = 0,
    Visible = Window.ShowBackdrop,
  })

  frame2.Parent = screenGui

  Window.Backdrop = frame2

  ;(createInstance("UIGradient", {
    Color = (ColorSequence.new({
      (ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 18, 22))),
      (ColorSequenceKeypoint.new(0.55, Color3.fromRGB(5, 7, 11))),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
    })),
    Rotation = 35,
  })).Parent = frame2

  local size2 = value.Size or udim3

  local frame3 = (createInstance("Frame", {
    Name = "Window",
    Size = size2,
    Position = value.Position or udim4,
    BackgroundTransparency = 1,
    BorderColor3 = Theme.Border,
    BorderSizePixel = 1,
    ClipsDescendants = true,
  }, { addCorner(18) }))

  frame3.Parent = screenGui

  Window.Frame = frame3
  frame3.Visible = Window.Visible
  local Window2 = Window

  Window._frameSize = value.Size or udim3
  local Window3 = Window

  Window._framePosition = value.Position or udim4

  local frame4 = (createInstance("Frame", {
    Active = false,
    AnchorPoint = (Vector2.new(0.5, 0.5)),
    BackgroundColor3 = (Color3.fromRGB(255, 255, 255)),
    BackgroundTransparency = 0.08,
    BorderSizePixel = 0,
    Position = (UDim2.fromOffset(0, 0)),
    Size = (UDim2.fromOffset(7, 7)),
    Visible = false,
    ZIndex = 1000,
    Parent = screenGui,
  }, { (addCorner(12)), createLabel((Color3.fromRGB(255, 255, 255)), 0.55) }))

  runService.RenderStepped:Connect(function(delta)
    if not frame4.Parent then
      return
    else
      if not Window.Visible then
        frame4.Visible = false
        return
      else

        local getMouseLocation = userInputService:GetMouseLocation()

        frame4.Position = UDim2.fromOffset(getMouseLocation.X, getMouseLocation.Y)
        frame4.Visible = true

        return
      end
    end
  end)

  ;(createLabel((Color3.fromRGB(255, 255, 255)), 0.96, 1)).Parent = frame3

  ;(createInstance("Frame", {
    Name = "BgGradient",
    Size = (UDim2.new(1, 0, 1, 0)),
    BackgroundColor3 = Theme.Window,
    BorderSizePixel = 0,
    ZIndex = 0,
  }, { addCorner(18) })).Parent = frame3

  local frame5 = createInstance("Frame", {
    Name = "Sidebar",
    Size = (UDim2.new(0, value3, 1, 0)),
    BackgroundColor3 = Theme.Sidebar,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
  }, { (addCorner(14)), addPadding(18, 22, 14, 18) })

  frame5.Parent = frame3

  Window.Sidebar = frame5

  ;(createInstance("Frame", {
    Name = "SidebarRightSquare",
    Position = (UDim2.new(1, -14, 0, 0)),
    Size = (UDim2.new(0, 14, 1, 0)),
    BackgroundColor3 = Theme.Sidebar,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ZIndex = 0,
  })).Parent = frame5

  local frame6 = createInstance("Frame", {
    Name = "Content",
    Size = (UDim2.new(1, -value3, 1, 0)),
    Position = (UDim2.new(0, value3, 0, 0)),
    BackgroundTransparency = 1,
  }, {
    addPadding(mobile and 16 or 24, mobile and 16 or 22, mobile and 18 or 26, mobile and 16 or 22),
  })

  frame6.Parent = frame3

  Window.Content = frame6

  local frame7 = createInstance("Frame", {
    Name = "Logo",
    Position = (UDim2.new(0, 8, 0, 0)),
    Size = (UDim2.new(1, -8, 0, 38)),
    BackgroundTransparency = 1,
  })

  frame7.Parent = frame5

  Window.Logo = frame7

  local result = fitTextSize({
    Text = Window.Title,
    Size = (UDim2.new(0, 88, 0, 36)),
    TextSize = (getThemeColor("WindowTitle")),
    Font = builderSans,
    Color = Theme.Text,
    Truncate = Enum.TextTruncate.AtEnd,
  })

  result.Parent = frame7

  Window.TitleLabel = result

  local result2 = fitTextSize({
    Text = Window.Version,
    Position = (UDim2.new(0, 94, 0, 0)),
    Size = (UDim2.new(0, 58, 0, 18)),
    TextSize = (getThemeColor("VersionLabel")),
    Font = builderSans,
    Color = Window.Theme.Primary,
    X = Enum.TextXAlignment.Left,
  })

  result2.Parent = frame7

  Window.VersionLabel = result2
  createButton(result2, Window.Theme.Primary, Window.Theme.Accent, nil, Window)
  table.insert(Window.ThemeObjects, { Object = result2, Property = "TextColor3", Role = "Primary" })

  local result3 = fitTextSize({
    Text = "Develop by yk0r",
    Position = (UDim2.new(0, 0, 0, 36)),
    Size = (UDim2.new(1, 0, 0, 14)),
    TextSize = (getThemeColor("CreditLabel")),
    Font = builderSans,
    Color = (Color3.new(1, 1, 1)),
  })

  result3.TextTransparency = 0.5
  result3.Parent = frame7

  Window.CreditLabel = result3

  local scrollingFrame = createInstance("ScrollingFrame", {
    Name = "Navigation",
    Size = (UDim2.new(1, 0, 1, -60)),
    Position = (UDim2.new(0, 0, 0, 60)),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    CanvasSize = (UDim2.new(0, 0, 0, 0)),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    ScrollBarThickness = 0,
    ScrollingEnabled = true,
  }, {
    createInstance("UIListLayout", {
      FillDirection = Enum.FillDirection.Vertical,
      SortOrder = Enum.SortOrder.LayoutOrder,
      Padding = (UDim.new(0, 4)),
    }),
  })

  scrollingFrame.Parent = frame5

  Window.Nav = scrollingFrame

  local frame8 = createInstance("Frame", {
    Name = "Header",
    Size = (UDim2.new(1, 0, 0, 42)),
    BackgroundTransparency = 1,
  })

  frame8.Parent = frame6

  Window.Header = frame8
  local tbl = { Active = false, Start = nil, StartPos = nil }

  frame8.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
      tbl.Active = true
      tbl.Start = input.Position
      tbl.StartPos = frame3.Position
    end

    return
  end)

  userInputService.InputChanged:Connect(function(input2)

    local active = tbl.Active and input2.UserInputType == Enum.UserInputType.MouseMovement

    if active then
      local position = input2.Position - tbl.Start

      frame3.Position = UDim2.new(
        tbl.StartPos.X.Scale, tbl.StartPos.X.Offset + position.X, tbl.StartPos.Y.Scale,
        tbl.StartPos.Y.Offset + position.Y
      )
    end

    return
  end)

  userInputService.InputEnded:Connect(function(input3)
    if input3.UserInputType == Enum.UserInputType.MouseButton1 then
      tbl.Active = false
    end

    return
  end)

  local value6 = mobile and 30 or 26

  local frame9 = createInstance("Frame", {
    Name = "WindowControls",
    AnchorPoint = (Vector2.new(1, 0)),
    Position = (UDim2.new(1, -10, 0, 7)),
    Size = (UDim2.new(0, value6 * 2 + 6, 0, value6)),
    BackgroundTransparency = 1,
    ZIndex = 10,
  })

  frame9.Parent = frame3

  local textButton = (createInstance("TextButton", {
    Name = "HideButton",
    Text = "-",
    AutoButtonColor = false,
    Position = (UDim2.new(0, 0, 0, 0)),
    Size = (UDim2.new(0, value6, 0, value6)),
    BackgroundColor3 = Theme.Sidebar,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Font = builderSans,
    TextSize = value6 * 0.72,
    TextColor3 = Theme.Text,
    TextXAlignment = Enum.TextXAlignment.Center,
    ZIndex = 10,
  }, { addCorner(8) }))

  textButton.Parent = frame9

  textButton.MouseButton1Click:Connect(function()
    local Window4 = Window
    Window:Hide()
    return
  end)

  textButton.MouseEnter:Connect(function()
    textButton.BackgroundTransparency = 0.88
    return
  end)

  textButton.MouseLeave:Connect(function()
    textButton.BackgroundTransparency = 1
    return
  end)

  local textButton2 = (createInstance("TextButton", {
    Name = "CloseButton",
    Text = "×",
    AutoButtonColor = false,
    Position = (UDim2.new(0, value6 + 6, 0, 0)),
    Size = (UDim2.new(0, value6, 0, value6)),
    BackgroundColor3 = Theme.Sidebar,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Font = builderSans,
    TextSize = value6 * 0.8,
    TextColor3 = Theme.Text,
    TextXAlignment = Enum.TextXAlignment.Center,
    ZIndex = 10,
  }, { addCorner(8) }))

  textButton2.Parent = frame9

  textButton2.MouseButton1Click:Connect(function()
    local Window5 = Window
    Window:Destroy()
    return
  end)

  textButton2.MouseEnter:Connect(function()
    textButton2.BackgroundColor3 = Color3.fromRGB(255, 59, 48)
    textButton2.BackgroundTransparency = 0.78
    return
  end)

  textButton2.MouseLeave:Connect(function()
    textButton2.BackgroundColor3 = Theme.Sidebar
    textButton2.BackgroundTransparency = 1
    return
  end)

  local scrollingFrame2 = createInstance("ScrollingFrame", {
    Name = "Cards",
    Size = (UDim2.new(1, 0, 1, -54)),
    Position = (UDim2.new(0, 0, 0, 54)),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    CanvasSize = (UDim2.new(0, 0, 0, 0)),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollBarThickness = 2,
    ScrollBarImageColor3 = (Color3.fromRGB(255, 255, 255)),
    ScrollBarImageTransparency = 0.88,
  }, { addPadding(0, 0, 5, 20) })

  scrollingFrame2.Parent = frame6

  Window.Scroll = scrollingFrame2

  local frame10 = createInstance("Frame", {
    Name = "List",
    Size = (UDim2.new(1, -5, 0, 0)),
    AutomaticSize = Enum.AutomaticSize.Y,
    BackgroundTransparency = 1,
  }, {
    createInstance("UIListLayout", {
      FillDirection = Enum.FillDirection.Vertical,
      SortOrder = Enum.SortOrder.LayoutOrder,
      Padding = (UDim.new(0, 7)),
    }),
  })

  frame10.Parent = scrollingFrame2

  Window.List = frame10

  function Window:SetVisible(visible)
    local value = visible == true
    local frame

    if self.Visible == value then
      return
    else
      self.Visible = value
      frame = self.Frame

      if not frame then
        return
      else
        local frameSize = self._frameSize

        local value2 = not frameSize

        local framePosition = self._framePosition

        if value2 or not framePosition then
          frame.Visible = value

          if self.Backdrop then
            local backdrop = self.Backdrop

            backdrop.Visible = value and self.ShowBackdrop
          end

          return
        else
          local udim5 = UDim2.new(
            framePosition.X.Scale + frameSize.X.Scale / 2,
            framePosition.X.Offset + frameSize.X.Offset / 2,
            framePosition.Y.Scale + frameSize.Y.Scale / 2,
            framePosition.Y.Offset + frameSize.Y.Offset / 2
          )

          local udim6 = UDim2.new(0, 0, 0, 0)

          if value then
            frame.Size = udim6
            frame.Position = udim5
            frame.Visible = true

            tweenTo(frame, { Size = frameSize, Position = framePosition }, 0.25)

            if self.Backdrop then
              self.Backdrop.Visible = self.ShowBackdrop
            end
          else
            tweenTo(frame, { Size = udim6, Position = udim5 }, 0.25)

            task.delay(0.25, function()
              frame.Visible = false

              if self.Backdrop then
                self.Backdrop.Visible = false
              end

              return
            end)
          end

          return
        end
      end
    end
  end

  function Window.Show(self)
    self:SetVisible(true)
    return
  end

  function Window:Hide()
    self:SetVisible(false)
    return
  end

  function Window:Toggle()
    self:SetVisible(not self.Visible)
    return
  end

  function Window:SetToggleKey(key)
    self.ToggleKey = normalizeKeyCode(key, Enum.KeyCode.RightShift)
    return
  end

  function Window:_handleKeybindInput(input, gameProcessed)
    local getFocusedTextBox = gameProcessed

    if not gameProcessed then
      getFocusedTextBox = userInputService:GetFocusedTextBox()
    end

    if getFocusedTextBox then
      return
    else
      for index2, value2 in ipairs(self.Keybinds) do
        if value2.Capturing then
          return
        end
      end

      if self.ToggleKey and input.KeyCode == self.ToggleKey then
        self:Toggle()
      end

      for index3, value3 in ipairs(self.Keybinds) do

        if value3.KeyCode and input.KeyCode == value3.KeyCode then
          safeCall(value3.Callback, value3.KeyCode)

          if value3.Module then
            local name2 = value3.Module.Name

            self:Notify({
              Title = name2,
              Content = value3.Module.Enabled and "Enabled" or "Disabled",
              Duration = 2,
            })
          end
        end
      end

      return
    end
  end

  local toggleKey = value.ToggleKey
  local toggleKeybind = toggleKey

  if not toggleKey then

    toggleKeybind = value.ToggleKeybind or value.MenuKey
  end

  if toggleKeybind then
    local Window6 = Window

    local toggleKey2 = value.ToggleKey

    local toggleKeybind2 = toggleKey2

    if not toggleKey2 then

      toggleKeybind2 = value.ToggleKeybind or value.MenuKey
    end

    Window:SetToggleKey(toggleKeybind2)
  end

  Window.InputConnection = userInputService.InputBegan:Connect(function(input4, gameProcessed)
    local Window7 = Window
    Window:_handleKeybindInput(input4, gameProcessed)
    return
  end)

  function Window:Notify(title, content, duration)

    local opts = (type(title)) == "table" and title
      or { Title = title, Content = content, Duration = duration }

    local notifyOpts = opts
    local title2 = opts.Title
    local name3 = title2

    if not title2 then

      name3 = opts.Name or "Notification"
    end

    local text3 = tostring(name3)
    local tostring2 = tostring
    local content = opts.Content
    local content2 = content

    if not content then
      local message = opts.Message

      local text4 = message

      if not message then

        text4 = opts.Text or ""
      end

      content2 = text4
    end

    local versionString = tostring2
    local result = tostring2(content2)

    local value = (tonumber(opts.Duration or opts.Time)) or 3
    local color = opts.Color ~= nil
    local result2 = resolveColor(opts.Color, self.Theme.Primary)
    local isMobile = self.IsMobile and 260 or 310
    local value2 = result ~= "" and 76 or 56

    local frame = (createInstance("Frame", {
      Size = (UDim2.new(0, isMobile, 0, 0)),
      BackgroundColor3 = Theme.Card,
      BackgroundTransparency = 1,
      BorderColor3 = Theme.Border,
      BorderSizePixel = 1,
      ClipsDescendants = true,
      ZIndex = 81,
    }, { addCorner(7) }))

    frame.Parent = self.Notifications

    local value3 = (fitTextSize({
      Text = text3,
      Position = (UDim2.new(0, 14, 0, 10)),
      Size = (UDim2.new(1, -28, 0, 22)),
      TextSize = (getThemeColor("NotificationTitle")),
      Font = builderSans,
      Color = Theme.Text,
      Truncate = Enum.TextTruncate.AtEnd,
      ZIndex = 82,
    }))

    value3.TextTransparency = 1
    value3.Parent = frame

    local value4 = (fitTextSize({
      Text = result,
      Position = (UDim2.new(0, 14, 0, 34)),
      Size = (UDim2.new(1, -28, 0, 24)),
      TextSize = (getThemeColor("NotificationBody")),
      Color = Theme.SubText,
      Wrapped = true,
      Truncate = Enum.TextTruncate.AtEnd,
      ZIndex = 82,
    }))

    value4.TextTransparency = 1
    value4.Visible = result ~= ""
    value4.Parent = frame

    local vector = Vector2.new(0, 1)
    local udim7 = UDim2.new(0, 12, 1, -8)
    local udim8 = UDim2.new(1, -24, 0, 2)
    local value5 = color and result2
    local themeColor = value5

    local frame2 = (createInstance("Frame", {
      AnchorPoint = vector,
      Position = udim7,
      Size = udim8,
      BackgroundColor3 = value5 or Color3.new(1, 1, 1),
      BackgroundTransparency = 1,
      BorderSizePixel = 0,
      ZIndex = 82,
    }, { addCorner(100) }))

    if not color then
      createButton(frame2, self.Theme.Primary, self.Theme.Accent, nil, self)
    end

    frame2.Parent = frame

    tweenTo(frame, { Size = (UDim2.new(0, isMobile, 0, value2)), BackgroundTransparency = 0 }, 0.2)
    tweenTo(value3, { TextTransparency = 0 }, 0.2)
    tweenTo(value4, { TextTransparency = 0 }, 0.2)
    tweenTo(frame2, { BackgroundTransparency = 0.15 }, 0.2)
    tweenTo(frame2, { Size = (UDim2.new(0, 0, 0, 2)) }, value)

    ;(coroutine.wrap(function()
      wait(value)

      if not frame.Parent then
        return
      else
        tweenTo(frame, { Size = (UDim2.new(0, isMobile, 0, 0)), BackgroundTransparency = 1 }, 0.22)
        tweenTo(value3, { TextTransparency = 1 }, 0.18)
        tweenTo(value4, { TextTransparency = 1 }, 0.18)
        tweenTo(frame2, { BackgroundTransparency = 1 }, 0.18)

        wait(0.24)

        if frame.Parent then
          local notifyFrame = frame
          frame:Destroy()
        end

        return
      end
    end))()

    return frame
  end

  function Window:_layoutLogo()

    local value = not self.TitleLabel or not self.VersionLabel

    if value then
      return
    else
      local isMobile2 = self.IsMobile

      local value2 = isMobile2 and math.max(88, self.SidebarWidth - 52) or 160

      local value3 = (math.ceil(createTextContainer(
        self.VersionLabel.Text, self.VersionLabel.TextSize, self.VersionLabel.Font
      ))) + 2

      local max = math.max(40, value2 - value3 - 5)

      local min = math.min((math.ceil(createTextContainer(
        self.TitleLabel.Text, self.TitleLabel.TextSize, self.TitleLabel.Font
      ))) + 2, max)

      self.TitleLabel.Size = UDim2.new(0, min, 0, 36)
      self.VersionLabel.Position = UDim2.new(0, min + 5, 0, 4)
      self.VersionLabel.Size = UDim2.new(0, value3, 0, 18)

      return
    end
  end

  local Window8 = Window

  Window:_layoutLogo()
  Window.TitleLabel.Text = Window.Title

  function Window:_themeColor(key)

    if key == "Accent" then
      return self.Theme.Accent
    else
      return self.Theme.Primary
    end
  end

  function Window:_registerTheme(name, primary, accent, extra1, extra2)
    return
  end

  function Window:_syncNavTheme()

    for index4, value4 in ipairs(self.TabOrder) do
      if value4.NavButton then
        createButton(value4.NavButton, self.Theme.Primary, self.Theme.Accent, nil, self)
      end
    end

    return
  end

  function Window:_applyTheme(theme)
    local primary = self.Theme.Primary
    local accent = self.Theme.Accent

    for index5, value5 in ipairs(self.ThemeObjects) do

      if value5.Object and value5.Object.Parent then

        if (value5.Property == "BackgroundColor3" or value5.Property == "TextColor3")
          and not value5.NoGradient then
          local flag = true

          if value5.Condition then
            local themeColor = self:_themeColor(value5.Role)

            local condOk1
            local condResult1
            condOk1, condResult1 = pcall(value5.Condition, themeColor)

            if condOk1 then

              condOk1 = condResult1 and condResult1 ~= themeColor
            end

            if condOk1 then
              flag = false
              clearThemeGradient(value5.Object, self)

              pcall(function()
                tweenTo(value5.Object, { [value5.Property] = condResult1 }, 0.18)
                return
              end)
            end
          end

          if flag then
            createButton(value5.Object, primary, accent, nil, self)
          end
        else

          if value5.NoGradient and value5.Property == "BackgroundColor3" then
            clearThemeGradient(value5.Object, self)
          end

          local themeColor2 = (self:_themeColor(value5.Role))

          if value5.Condition then
            local condOk2, condResult2
            condResult2, condOk2 = pcall(value5.Condition, themeColor2)

            if condResult2 and condOk2 then
              themeColor2 = condOk2
            end
          end

          pcall(function()
            tweenTo(value5.Object, { [value5.Property] = themeColor2 }, 0.18)
            return
          end)
        end
      end
    end

    if self._island then
      self._island.BackgroundColor3 = Color3.fromRGB(
        (math.floor(primary.R * 127.5)), (math.floor(primary.G * 127.5)),
        math.floor(primary.B * 127.5)
      )
    end

    if self._islandBorder then
      createButton(self._islandBorder, primary, accent, nil, self)
    end

    self:_syncNavTheme()

    if theme then

      local canvasPosition = self.Scroll and self.Scroll.CanvasPosition

      local activeTabName = self.ActiveTabName

      local firstTabName = activeTabName

      if not activeTabName then

        firstTabName = self.FirstTabName or "Search"
      end

      self:SelectTab(firstTabName)

      if canvasPosition and self.Scroll then
        self.Scroll.CanvasPosition = canvasPosition
      end
    end

    return
  end

  function Window:_startGradientAnimation()
    local counter

    if self._gradientHeartbeat then
      return
    else
      counter = 0

      self._gradientHeartbeat = runService.Heartbeat:Connect(function()
        local result = tick()
        local value = (math.sin(result * 0.3 * math.pi)) * 0.65

        for index6, value6 in ipairs(self._gradientInstances) do
          if value6.Parent then
            value6.Offset = Vector2.new(value, 0)
          end
        end

        counter = counter + 1

        if counter % 60 == 0 then
          local gradientInstances2 = self._gradientInstances

          local num = 0

          for i = 1, #gradientInstances2 do
            local value2 = gradientInstances2[i]

            if value2 and value2.Parent then
              num = num + 1
              gradientInstances2[num] = value2
            end
          end

          for j = #gradientInstances2, num + 1, -1 do
            gradientInstances2[j] = nil
          end
        end

        return
      end)

      return
    end
  end

  function Window:_stopGradientAnimation()

    if self._gradientHeartbeat then

      self._gradientHeartbeat:Disconnect()
      self._gradientHeartbeat = nil
    end

    for index7, value7 in ipairs(self._gradientInstances) do
      if value7.Parent then
        value7.Offset = Vector2.new(0, 0)
      end
    end

    return
  end

  function Window:SetGradientAnimation(enabled)
    self.GradientAnimation = enabled == true

    if self.GradientAnimation then
      self:_startGradientAnimation()
    else
      self:_stopGradientAnimation()
    end

    return
  end

  function Window:SetTheme(themeName)

    if themeName == "Custom" and self.CustomTheme then
      self.ThemeName = "Custom"
      self.Theme = self.CustomTheme
      self:_applyTheme(true)

      return
    else
      if not Themes[themeName] then
        return
      else
        self.ThemeName = themeName
        self.Theme = Themes[themeName]
        self:_applyTheme(true)

        return
      end
    end
  end

  function Window:SetCustomTheme(primary, accent)
    local result = resolveColor(primary, self.Theme.Primary)

    self.CustomTheme = { Name = "Custom", Primary = result, Accent = (resolveColor(accent, result)) }
    self.ThemeName = "Custom"
    self.Theme = self.CustomTheme
    self:_applyTheme(false)

    return
  end

  function Window:_clear()
    local list = self.List

    for index8, value8 in ipairs(list:GetChildren()) do
      if (value8:IsA("GuiObject")) then
        local flag = false

        for index9, value9 in ipairs(self.Modules) do
          if value9.Card == value8 then
            flag = true
            break
          end
        end

        if flag then
          value8.Parent = nil
        else
          value8:Destroy()
        end
      end
    end

    return
  end

  function Window:_setHeader(text)
    local header = self.Header
    header:ClearAllChildren()
    local textBox

    if text == "Search" then
      textBox = (createInstance("TextBox", {
        Text = self.SearchQuery,
        PlaceholderText = "Search player...",
        ClearTextOnFocus = false,
        Size = (UDim2.new(1, 0, 1, 0)),
        BackgroundTransparency = 1,
        TextColor3 = Theme.Text,
        PlaceholderColor3 = Theme.Muted,
        TextSize = (getThemeColor("SearchBox")),
        Font = builderSans,
        TextXAlignment = Enum.TextXAlignment.Center,
      }))

      textBox.Parent = self.Header
      textBox.PlaceholderText = "Start typing to search..."

      ;(textBox:GetPropertyChangedSignal("Text")):Connect(function()
        self.SearchQuery = textBox.Text
        local self2 = self
        self:_renderSearch()
        return
      end)
    else
    end

    return
  end

  function Window:_makeInfoCard(text5)
    local frame = createInstance("Frame", {
      Size = (UDim2.new(1, 0, 0, 58)),
      BackgroundColor3 = Theme.Card,
      BorderColor3 = Theme.Border,
      BorderSizePixel = 1,
    }, { addCorner(7) })

    ;(fitTextSize({
      Text = text5,
      Size = (UDim2.new(1, 0, 1, 0)),
      TextSize = (getThemeColor("InfoCard")),
      Color = Theme.SubText,
      X = Enum.TextXAlignment.Center,
    })).Parent = frame

    return frame
  end

  function Window:_renderSearch()
    local tabs = self.Tabs[self.ActiveTabName]

    local value = not tabs or tabs.Kind ~= "Search"

    if value then
      return
    else
      self:_clear()

      local lower = string.lower

      local result = lower(self.SearchQuery or "")

      local num = 0

      for index10, value10 in ipairs(self.Modules) do
        local lower = string.lower(value10.Name .. " " .. value10.Description .. " "
          .. value10.Tab.Name)

        local value2 = result == ""

        local themeValue = value2

        if value2 or string.find(lower, result, 1, true) then
          num = num + 1
          value10.CategoryLabel.Visible = true
          value10.Card.Parent = self.List
        end
      end

      if num == 0 then
        (self:_makeInfoCard("No results found")).Parent = self.List
      end

      return
    end
  end

  function Window:_renderCaS()

    local config = self.Tabs.Config or self.Tabs.CaS
    local renderConfigUI = config and config._renderConfigUI

    if renderConfigUI then
      config._renderConfigUI()
    else

      Library.CreateConfigSystem(self)

      local config2 = self.Tabs.Config or self.Tabs.CaS

      if config2 and config2._renderConfigUI then
        config2._renderConfigUI()
      end
    end

    return
  end

  function Window:_renderThemes()
    local self2 = self
    self:_clear()
    local isMobile3 = self.IsMobile
    local value = isMobile3 and 90 or 120
    local value2 = value - 20
    local value3 = (value - 20) * 0.6

    local frame = createInstance("Frame", {
      Size = (UDim2.new(1, 0, 0, 0)),
      AutomaticSize = Enum.AutomaticSize.Y,
      BackgroundTransparency = 1,
    }, {
      createInstance("UIGridLayout", {
        CellSize = (UDim2.new(0, value, 0, value3 + 40)),
        CellPadding = (UDim2.new(0, 10, 0, 10)),
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
      }),
    })

    frame:SetAttribute("SkipFade", true)
    frame.Parent = self.List

    local tbl = {}

    for key in pairs(Themes) do
      table.insert(tbl, key)
    end

    table.sort(tbl)

    for index11, value11 in ipairs(tbl) do

      local value4 = Themes[value11]

      local themeName = self.ThemeName == value11

      local udim9 = UDim2.new(1, 0, 1, 0)

      local card = Theme.Card

      local textButton = createInstance("TextButton", {
        Text = "",
        AutoButtonColor = false,
        Size = udim9,
        BackgroundColor3 = card,
        BorderColor3 = themeName and self.Theme.Primary or Theme.Border,
        BorderSizePixel = themeName and 2 or 1,
      }, { addCorner(8) })

      textButton.Parent = frame

      local frame2 = createInstance("Frame", {
        Position = (UDim2.new(0.5, -(math.floor(value2 / 2)), 0, 8)),
        Size = (UDim2.new(0, value2, 0, value3)),
        BackgroundColor3 = (Color3.new(1, 1, 1)),
        BorderSizePixel = 0,
      }, { addCorner(8) })

      local uiGradient = createInstance("UIGradient", {
        Rotation = 0,
        Color = (ColorSequence.new(value4.Primary, value4.Accent)),
      })

      if self._gradientInstances then
        table.insert(self._gradientInstances, uiGradient)
      end

      uiGradient.Parent = frame2
      frame2.Parent = textButton

      local value5 = value3 + 8

      ;(fitTextSize({
        Text = value4.Name,
        Position = (UDim2.new(0, 4, 0, value5)),
        Size = (UDim2.new(1, -8, 0, 16)),
        TextSize = (getThemeColor("ThemeName", isMobile3)),
        Font = builderSans,
        Color = Theme.Text,
        X = Enum.TextXAlignment.Center,
        Truncate = Enum.TextTruncate.AtEnd,
      })).Parent = textButton

      if themeName then
        (fitTextSize({
          Text = "Active",
          Position = (UDim2.new(0, 4, 0, value5 + 16)),
          Size = (UDim2.new(1, -8, 0, 16)),
          TextSize = (getThemeColor("ActiveBadge")),
          Font = builderSans,
          Color = self.Theme.Primary,
          X = Enum.TextXAlignment.Center,
        })).Parent = textButton
      end

      textButton.MouseButton1Click:Connect(function()
        local self3 = self
        self:SetTheme(value11)
        return
      end)
    end

    return
  end

  function Window:SelectTab(tabName)
    local tabs = self.Tabs[tabName]

    if not tabs then
      return
    else
      self.ActiveTabName = tabName

      local kind = tabs.Kind or tabs.Name

      for index12, value12 in ipairs(self.TabOrder) do
        local name = value12.Name == tabName

        tweenTo(value12.NavButton, { BackgroundTransparency = name and 0 or 1 }, 0.4)
        createButton(value12.NavButton, self.Theme.Primary, self.Theme.Accent, nil, self)

        local tweenTo2 = tweenTo

        local navLabel = value12.NavLabel

        tweenTo(navLabel, { TextColor3 = name and Theme.Text or Theme.SubText }, 0.4)
      end

      self.Header:ClearAllChildren()
      self:_clear()

      if kind == "Search" then
        self:_setHeader("Search")
        self:_renderSearch()
      else
        if kind == "Themes" then
          self:_renderThemes()
        else
          if kind == "CaS" then
            self:_renderCaS()
          else
            if kind == "PlayerList" then
              self:_renderPlayerList()
            else

              if tabs._isConfigSystem and tabs._renderConfigUI then
                tabs._renderConfigUI()
              end

              for index13, value13 in ipairs(tabs.Modules) do
                value13.CategoryLabel.Visible = false
                value13.Card.Parent = self.List
              end
            end
          end
        end
      end

      if kind == "Search" then
        self:_renderSearch()
      end

      for index14, value14 in ipairs(self.List:GetChildren()) do
        local guiObject = value14:IsA("GuiObject")

        local textButton = guiObject

        if guiObject then
          local frame2 = value14:IsA("Frame")

          textButton = frame2 or value14:IsA("TextButton")
        end

        if textButton then
          if not (value14:GetAttribute("SkipFade")) then
            value14.BackgroundTransparency = 1
            tweenTo(value14, { BackgroundTransparency = 0 }, 0.4)
          end
        end
      end

      for index15, value15 in ipairs(self.Header:GetChildren()) do
        local guiObject2 = value15:IsA("GuiObject")

        local textButton2 = guiObject2

        if guiObject2 then
          local frame3 = value15:IsA("Frame")

          textButton2 = frame3 or value15:IsA("TextButton")
        end

        if textButton2 then
          value15.BackgroundTransparency = 1
          tweenTo(value15, { BackgroundTransparency = 0 }, 0.4)
        end
      end

      self.Scroll.CanvasPosition = Vector2.new(0, 0)
      return
    end
  end

  function Window:CreateTab(name)

    local opts = (type(name)) == "table" and name or { Name = name }
    local name4 = opts.Name
    local key2 = name4

    if not name4 then

      key2 = opts.Key or "Tab"
    end

    local value = (tostring(key2))

    local key3 = opts.Key or value

    local kind2 = opts.Kind or value

    local Module = {
      Window = self,
      Name = value,
      Key = key3,
      Kind = kind2,
      Modules = {},
    }

    self.Tabs[value] = Module
    table.insert(self.TabOrder, Module)

    local textButton = (createInstance("TextButton", {
      Text = "",
      AutoButtonColor = false,
      Size = (UDim2.new(1, 0, 0, 32)),
      BackgroundColor3 = self.Theme.Accent,
      BackgroundTransparency = 1,
      BorderSizePixel = 0,
    }, { addCorner(100) }))

    textButton.Parent = self.Nav

    local value2 = (fitTextSize({
      Text = value,
      Position = (UDim2.new(0, 22, 0, 0)),
      Size = (UDim2.new(1, -28, 1, 0)),
      TextSize = (getThemeColor("NavLabel")),
      Font = builderSans,
      Color = Theme.SubText,
    }))

    value2.Parent = textButton
    value2.Text = value

    Module.NavButton = textButton
    Module.NavLabel = value2

    textButton.MouseButton1Click:Connect(function()
      local self2 = self
      self:SelectTab(value)
      return
    end)

    textButton.MouseEnter:Connect(function()
      if self.ActiveTabName ~= value then
        textButton.BackgroundTransparency = 0.96
        value2.TextColor3 = Theme.Text
      end

      return
    end)

    textButton.MouseLeave:Connect(function()
      if self.ActiveTabName ~= value then
        textButton.BackgroundTransparency = 1
        value2.TextColor3 = Theme.SubText
      end

      return
    end)

    function Module.CreateModule(self, moduleName, icon, options)

      local opts = (type(moduleName)) == "table" and moduleName
        or { Name = moduleName, Description = icon, Default = options }

      local opts2 = opts
      local window = self.Window

      local name5 = tostring(opts.Name or "Module")
      local tostring2 = tostring
      local description = opts.Description
      local desc = description

      if not description then

        desc = opts.Desc or ""
      end

      local description2 = tostring2(desc)

      local Tab = {
        Tab = self,
        Window = window,
        Name = name5,
        Description = description2,
        Enabled = opts.Default == true or opts.Enabled == true,
        Expanded = false,
        Controls = {},
        Callback = opts.Callback,
      }

      local Tab2 = Tab
      local Tab3 = Tab

      local id = opts.Id and tostring(opts.Id)

      if not id then

        local gsub3 = Tab.Name:gsub("%s+", "-")

        id = string.lower(gsub3:gsub("[^%w%-]", ""))
      end

      Tab.Id = id

      local frame = (createInstance("Frame", {
        Name = Tab.Id,
        Size = (UDim2.new(1, 0, 0, 74)),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = (Color3.fromRGB(22, 25, 33)),
        BackgroundTransparency = 0.4,
        BorderColor3 = Theme.Border,
        BorderSizePixel = 1,
        ClipsDescendants = true,
      }, {
        (addCorner(14)),
        createInstance("UIListLayout", {
          FillDirection = Enum.FillDirection.Vertical,
          SortOrder = Enum.SortOrder.LayoutOrder,
          Padding = (UDim.new(0, 0)),
        }),
      }))

      Tab.Card = frame

      local textButton = createInstance("TextButton", {
        Text = "",
        AutoButtonColor = false,
        Size = (UDim2.new(1, 0, 0, 74)),
        BackgroundTransparency = 1,
      })

      textButton.Parent = frame

      Tab.Header = textButton
      local name6 = Tab.Name
      local udim10 = UDim2.new(0, 12, 0, 9)
      local udim11 = UDim2.new(1, -92, 0, 25)
      local moduleTitle = getThemeColor("ModuleTitle")
      local fitTextSize2 = fitTextSize

      local result = fitTextSize({
        Text = name6,
        Position = udim10,
        Size = udim11,
        TextSize = moduleTitle,
        Font = builderSans,
        Color = Tab.Enabled and self.Window.Theme.Primary or Theme.Text,
      })

      result.Parent = textButton

      Tab.TitleLabel = result
      result.Text = Tab.Name

      self.Window:_registerTheme(result, "TextColor3", "Primary", function(colorValue)

        return Tab.Enabled and colorValue or Theme.Text
      end)

      local result2 = fitTextSize({
        Text = "(" .. Tab.Tab.Name .. ")",
        Position = (UDim2.new(0, 88, 0, 10)),
        Size = (UDim2.new(0, 100, 0, 22)),
        TextSize = (getThemeColor("CategoryLabel")),
        Color = Theme.Muted,
      })

      result2.Visible = false
      result2.Parent = textButton

      Tab.CategoryLabel = result2

      function Tab:LayoutHeaderText()

        local value = not self.TitleLabel or not self.CategoryLabel

        if value then
          return
        else

          local x2 = self.Header and self.Header.AbsoluteSize.X or 0

          if x2 <= 0 then
            x2 = 520
          end

          local ceil = math.ceil(createTextContainer(
            self.CategoryLabel.Text, self.CategoryLabel.TextSize, self.CategoryLabel.Font
          ))

          local clamp = math.clamp(ceil + 6, 58, 118)

          local max = math.max(64, x2 - 12 - 58 - clamp - 10)

          local ceil2 = math.ceil(createTextContainer(
            self.TitleLabel.Text, self.TitleLabel.TextSize, self.TitleLabel.Font
          ))

          local min = math.min(ceil2 + 4, max)

          self.TitleLabel.Size = UDim2.new(0, min, 0, 25)
          self.CategoryLabel.Position = UDim2.new(0, 12 + min + 6, 0, 10)
          self.CategoryLabel.Size = UDim2.new(0, clamp, 0, 22)

          return
        end
      end

      local Tab4 = Tab
      Tab:LayoutHeaderText()

      local result3 = fitTextSize({
        Text = Tab.Description,
        Position = (UDim2.new(0, 12, 0, 39)),
        Size = (UDim2.new(1, -42, 0, 22)),
        TextSize = (getThemeColor("Description")),
        Font = builderSans,
        Color = Theme.SubText,
        Truncate = Enum.TextTruncate.AtEnd,
      })

      result3.Parent = textButton
      result3.Text = Tab.Description

      local textButton2 = createInstance("TextButton", {
        Text = "+",
        AutoButtonColor = false,
        Position = (UDim2.new(1, -42, 0, 23)),
        Size = (UDim2.new(0, 26, 0, 26)),
        BackgroundColor3 = (Color3.fromRGB(255, 255, 255)),
        BackgroundTransparency = 0.97,
        BorderColor3 = Theme.Border,
        BorderSizePixel = 1,
        TextColor3 = Theme.SubText,
        TextSize = (getThemeColor("GearIcon")),
        Font = builderSans,
      }, { addCorner(100) })

      textButton2.Parent = textButton

      Tab.Gear = textButton2

      local frame2 = createInstance("Frame", {
        Name = "Settings",
        Size = (UDim2.new(1, 0, 0, 0)),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
      }, { addPadding(10, 0, 12, 14) })

      frame2.Parent = frame

      Tab.Body = frame2

      local uiListLayout = createInstance("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = (UDim.new(0, 1)),
      })

      uiListLayout.Parent = frame2

      Tab.BodyList = uiListLayout

      function Tab:_bodyHeight()
        return self.BodyList.AbsoluteContentSize.Y + 16
      end

      function Tab:_refreshBodyHeight()

        if self.Expanded then
          tweenTo(self.Body, { Size = (UDim2.new(1, 0, 0, self:_bodyHeight())) }, 0.18)
        end

        return
      end

      function Tab:SetExpanded(expanded)
        self.Expanded = expanded == true
        local expanded = self.Expanded

        local bodyHeight = expanded and self:_bodyHeight() or 0
        tweenTo(self.Body, { Size = (UDim2.new(1, 0, 0, bodyHeight)) }, 0.24)

        if self.Expanded then
          createButton(
            self.Gear, self.Window.Theme.Primary, self.Window.Theme.Accent, nil, self.Window
          )
        else
          clearThemeGradient(self.Gear, self.Window)
          self.Gear.TextColor3 = Theme.SubText
        end

        self.Gear.Rotation = self.Expanded and 45 or 0
        return
      end

      function Tab:Set(key, value)
        self.Enabled = key == true

        if self.Enabled then
          createButton(
            self.TitleLabel, self.Window.Theme.Primary, self.Window.Theme.Accent, nil,
            self.Window
          )
        else
          clearThemeGradient(self.TitleLabel, self.Window)
          tweenTo(self.TitleLabel, { TextColor3 = Theme.Text }, 0.18)
        end

        if not value then
          safeCall(self.Callback, self.Enabled)
        end

        return
      end

      function Tab:Get()
        return self.Enabled
      end

      function Tab:_row(label, children, options)

        local frame = (createInstance("Frame", {
          Size = (UDim2.new(1, 0, 0, self.Window.RowHeight)),
          BackgroundColor3 = (Color3.fromRGB(255, 255, 255)),
          BackgroundTransparency = 1,
          BorderSizePixel = 0,
        }))

        local rowFrame = frame

        frame:SetAttribute("OpenHeight", self.Window.RowHeight)
        frame.Parent = self.Body

        local num = 0

        if children then
          num = 34

          ;(createInstance("Frame", {
            Position = (UDim2.new(0, 18, 0, -1)),
            Size = (UDim2.new(0, 2, 1, 2)),
            BackgroundColor3 = Theme.Line,
            BorderSizePixel = 0,
          })).Parent = frame
        end

        local result = fitTextSize({
          Text = label,
          Position = (UDim2.new(0, num, 0, 0)),
          Size = (UDim2.new(0.42, -num, 1, 0)),
          TextSize = (getThemeColor("ControlText")),
          Color = Theme.Text,
        })

        result.Parent = frame

        if options then
          result.Text = options(label)
        end

        frame.MouseEnter:Connect(function()
          frame.BackgroundTransparency = 0.985
          return
        end)

        frame.MouseLeave:Connect(function()
          frame.BackgroundTransparency = 1
          return
        end)

        if self.Expanded then
          self:SetExpanded(true)
        end

        return frame, result
      end

      function Tab:_setControlVisible(control, visible)
        local value = not control
        local value2 = value or not control.Row

        if value2 then
          return
        else
          control.Visible = visible == true
          control.Row.Visible = control.Visible

          local row = control.Row

          local visible2 = control.Visible

          if visible2 then
            local new = UDim2.new

            visible2 = new(1, 0, 0, (control.Row:GetAttribute("OpenHeight")) or self.Window.RowHeight)
          end

          local isVisible = visible2

          row.Size = visible2 or UDim2.new(1, 0, 0, 0)

          for extraRowIndex, extraRow in ipairs(control.ExtraRows or {}) do
            local visible3 = control.Visible

            extraRow.Visible = visible3 and (extraRow:GetAttribute("Opened")) == true

            local visible4 = extraRow.Visible

            local udim12 = visible4
            udim12 = visible4 and UDim2.new(1, 0, 0, (extraRow:GetAttribute("OpenHeight")) or 0)

            extraRow.Size = udim12 or UDim2.new(1, 0, 0, 0)
          end

          self:_refreshBodyHeight()
          return
        end
      end

      function Tab:_attachParent(parent, control)

        if not control then
          return
        else

          control.Dependents = control.Dependents or {}
          table.insert(control.Dependents, parent)
          parent.ParentControl = control
          self:_setControlVisible(parent, control.Value == true)
          return
        end
      end

      function Tab.CreateButton(self, name, callback)

        local opts = (type(name)) == "table" and name or { Name = name, Callback = callback }
        local opts3 = opts

        local id2 = tostring(opts.Id or opts.Name)
        local tostring2 = tostring

        local name7 = tostring2(opts.Name or "Button")
        local callback = opts.Callback

        local tbl = {
          Type = "Button",
          Id = id2,
          Name = name7,
          Callback = callback,
          Module = self,
          Parent = opts.Parent or opts.ParentControl,
        }

        local row, rowLabel = self:_row(tbl.Name, opts.Nested)
        tbl.Row = row
        rowLabel.Font = builderSans

        row.InputBegan:Connect(function(input5)

          if input5.UserInputType == Enum.UserInputType.MouseButton1
            or input5.UserInputType == Enum.UserInputType.Touch then
            safeCall(tbl.Callback)
          end

          return
        end)

        function tbl.Fire(args)
          safeCall(args.Callback)
          return
        end

        function tbl:Get()
          return nil
        end

        table.insert(self.Controls, tbl)
        table.insert(self.Window.Controls, tbl)

        self:_attachParent(tbl, tbl.Parent)
        return tbl
      end

      function Tab.CreateInput(self, name, default, callback)

        local opts = (type(name)) == "table" and name
          or { Name = name, Default = default, Callback = callback }

        local opts4 = opts

        local id3 = tostring(opts.Id or opts.Name)
        local tostring2 = tostring

        local name8 = tostring2(opts.Name or "Input")
        local tostring3 = tostring
        local default = opts.Default
        local value16 = default

        if not default then

          value16 = opts.Value or ""
        end

        local value17 = tostring3(value16)
        local callback2 = opts.Callback

        local ToggleElement = {
          Type = "Input",
          Id = id3,
          Name = name8,
          Value = value17,
          Callback = callback2,
          Module = self,
          Parent = opts.Parent or opts.ParentControl,
        }

        local row2, rowLabel2 = self:_row(ToggleElement.Name, opts.Nested)
        ToggleElement.Row = row2
        local value18 = ToggleElement.Value
        local placeholder = opts.Placeholder
        local placeholderText = placeholder

        if not placeholder then

          placeholderText = opts.PlaceholderText or ""
        end

        local createInstance2 = createInstance

        local textBox = (createInstance("TextBox", {
          Text = value18,
          PlaceholderText = placeholderText,
          Position = (UDim2.new(1, -160, 0.5, -11)),
          Size = (UDim2.new(0, 146, 0, 22)),
          BackgroundColor3 = Theme.TrackHover,
          BorderColor3 = Theme.Border,
          BorderSizePixel = 1,
          TextColor3 = Theme.Text,
          PlaceholderColor3 = Theme.Muted,
          TextSize = (getThemeColor("InputBox")),
          Font = builderSans,
          ClearTextOnFocus = false,
        }, { addCorner(4) }))

        textBox.Parent = row2

        textBox.FocusLost:Connect(function()
          ToggleElement.Value = textBox.Text
          safeCall(ToggleElement.Callback, ToggleElement.Value)
          return
        end)

        function ToggleElement:Set(value, silent)

          self.Value = tostring(value or "")
          textBox.Text = self.Value

          if not silent then
            safeCall(self.Callback, self.Value)
          end

          return
        end

        function ToggleElement:Get()
          return self.Value
        end

        table.insert(self.Controls, ToggleElement)
        table.insert(self.Window.Controls, ToggleElement)

        self:_attachParent(ToggleElement, ToggleElement.Parent)

        if opts.Default ~= nil then
          safeCall(ToggleElement.Callback, ToggleElement.Value)
        end

        return ToggleElement
      end

      function Tab.CreateKeybind(self, name, default, callback)

        local opts = (type(name)) == "table" and name
          or { Name = name, Default = default, Callback = callback }

        local opts5 = opts

        local id4 = tostring(opts.Id or opts.Name)
        local tostring2 = tostring

        local name9 = tostring2(opts.Name or "Keybind")
        local default2 = opts.Default

        if not default2 then
          local currentKey = opts.CurrentKey

          local keybind = currentKey

          if not currentKey then

            keybind = opts.Keybind or opts.KeyCode
          end

          default2 = keybind
        end

        local keyCode = normalizeKeyCode(default2, nil)
        local callback3 = opts.Callback
        local self2 = self

        local KeybindElement = {
          Type = "Keybind",
          Id = id4,
          Name = name9,
          KeyCode = keyCode,
          Callback = callback3,
          Module = self,
          Parent = opts.Parent or opts.ParentControl,
          Capturing = false,
        }

        local self3 = self
        local row3, rowLabel3 = self:_row(KeybindElement.Name, opts.Nested)
        KeybindElement.Row = row3

        local textButton = (createInstance("TextButton", {
          Text = (keyCodeToLabel(KeybindElement.KeyCode)),
          AutoButtonColor = false,
          Position = (UDim2.new(1, -92, 0.5, -11)),
          Size = (UDim2.new(0, 78, 0, 22)),
          BackgroundColor3 = Theme.TrackHover,
          BorderColor3 = Theme.Border,
          BorderSizePixel = 1,
          TextColor3 = Theme.Text,
          TextSize = (getThemeColor("KeybindBox")),
          Font = builderSans,
        }, { addCorner(4) }))

        textButton.Parent = row3

        local function setKeybindCapturing(capturing)
          KeybindElement.Capturing = capturing == true
          local textButton8 = textButton

          local capturing = KeybindElement.Capturing and "..."

          textButton.Text = capturing or keyCodeToLabel(KeybindElement.KeyCode)

          if KeybindElement.Capturing then
            createButton(textButton, self.Window.Theme.Primary, self.Window.Theme.Accent, nil, self.Window)
          else
            clearThemeGradient(textButton, self.Window)
            textButton.BackgroundColor3 = Theme.TrackHover
            textButton.TextColor3 = Theme.Text
          end

          return
        end

        textButton.MouseButton1Click:Connect(function()
          setKeybindCapturing(true)
          return
        end)

        local inputBegan = userInputService.InputBegan

        KeybindElement.Connection = (inputBegan:Connect(function(input, gameProcessed)

          if not KeybindElement.Capturing then
            return
          else

            if (userInputService:GetFocusedTextBox()) then
              return
            else

              if input.UserInputType == Enum.UserInputType.Keyboard
                and input.KeyCode ~= Enum.KeyCode.Unknown then

                KeybindElement:Set(input.KeyCode, true)
                setKeybindCapturing(false)
              else
                if gameProcessed then
                  setKeybindCapturing(false)
                end
              end

              return
            end
          end
        end))

        function KeybindElement:Set(key, silent)
          self.KeyCode = normalizeKeyCode(key, self.KeyCode)
          textButton.Text = keyCodeToLabel(self.KeyCode)

          if not silent then
            safeCall(self.Callback, self.KeyCode)
          end

          return
        end

        function KeybindElement:Get()

          return self.KeyCode and self.KeyCode.Name
        end

        table.insert(self.Controls, KeybindElement)
        table.insert(self.Window.Controls, KeybindElement)
        table.insert(self.Window.Keybinds, KeybindElement)

        local self4 = self
        self:_attachParent(KeybindElement, KeybindElement.Parent)
        return KeybindElement
      end

      function Tab.CreateToggle(self, name, default, callback)

        local opts = (type(name)) == "table" and name
          or { Name = name, Default = default, Callback = callback }

        local opts6 = opts

        local id5 = tostring(opts.Id or opts.Name)
        local tostring2 = tostring

        local name10 = tostring2(opts.Name or "Toggle")
        local value19 = opts.Default == true
        local callback4 = opts.Callback

        local ButtonElement = {
          Type = "Toggle",
          Id = id5,
          Name = name10,
          Value = value19,
          Callback = callback4,
          Module = self,
          Parent = opts.Parent or opts.ParentControl,
          Dependents = {},
        }

        local row2 = self:_row(ButtonElement.Name, opts.Nested)
        ButtonElement.Row = row2

        ;(createInstance("Frame", {
          Position = (UDim2.new(
            1, -(14 + self.Window.ToggleSize), 0.5, -(math.floor(self.Window.ToggleSize / 2))
          )),
          Size = (UDim2.new(0, self.Window.ToggleSize, 0, self.Window.ToggleSize)),
          BackgroundColor3 = Theme.Track,
          BorderSizePixel = 0,
        }, { addCorner(100) })).Parent = row2

        local udim13 = UDim2.new(
          1, -(14 + self.Window.ToggleSize), 0.5, -(math.floor(self.Window.ToggleSize / 2))
        )

        local udim14 = UDim2.new(0, self.Window.ToggleSize, 0, self.Window.ToggleSize)
        local primary2 = self.Window.Theme.Primary
        local value20 = ButtonElement.Value and 0 or 1
        local createInstance2 = createInstance

        local primary3 = ButtonElement.Value and self.Window.Theme.Primary or Theme.Muted
        local createInstance3 = createInstance

        local textButton = (createInstance("TextButton", {
          Text = "",
          AutoButtonColor = false,
          Position = udim13,
          Size = udim14,
          BackgroundColor3 = primary2,
          BackgroundTransparency = value20,
          BorderColor3 = primary3,
          BorderSizePixel = 1,
        }, { addCorner(100) }))

        textButton.Parent = row2

        self.Window:_registerTheme(textButton, "BackgroundColor3", "Primary", nil, true)

        function ButtonElement:Set(value, silent)
          self.Value = value == true
          local textButton2 = textButton
          textButton.BackgroundTransparency = self.Value and 0 or 1
          local textButton9 = textButton

          textButton.BorderColor3 = self.Value and self.Module.Window.Theme.Primary or Theme.Muted

          for depIndex, dependent in ipairs(self.Dependents or {}) do

            self.Module:_setControlVisible(dependent, self.Value)
          end

          if not silent then
            safeCall(self.Callback, self.Value)
          end

          return
        end

        function ButtonElement:Get()
          return self.Value
        end

        row2.InputBegan:Connect(function(input6)

          local userInputType = input6.UserInputType == Enum.UserInputType.MouseButton1
            or input6.UserInputType == Enum.UserInputType.Touch

          if userInputType then
            local ButtonElement2 = ButtonElement
            ButtonElement:Set(not ButtonElement.Value)
          end

          return
        end)

        table.insert(self.Controls, ButtonElement)
        table.insert(self.Window.Controls, ButtonElement)

        self:_attachParent(ButtonElement, ButtonElement.Parent)

        if opts.Default ~= nil then
          safeCall(ButtonElement.Callback, ButtonElement.Value)
        end

        return ButtonElement
      end

      function Tab.CreateSelector(self, name, opts, default, callback)

        local opts2 = (type(name)) == "table" and name or {
          Name = name,
          Options = opts,
          Default = default,
          Callback = callback,
        }

        local opts7 = opts2
        local options = opts2.Options
        local values = options

        if not options then

          values = opts2.Values or {}
        end

        local id6 = tostring(opts2.Id or opts2.Name)
        local tostring2 = tostring

        local name11 = tostring2(opts2.Name or "Selector")
        local default3 = opts2.Default
        local callback5 = opts2.Callback

        local DropdownElement = {
          Type = "Selector",
          Id = id6,
          Name = name11,
          Options = values,
          Value = default3,
          Callback = callback5,
          Module = self,
          Parent = opts2.Parent or opts2.ParentControl,
        }

        function DropdownElement:_optionValue(option)

          if (type(option)) == "table" then
            local value21 = option.Value

            if not value21 then
              local id7 = option.Id

              if not id7 then
                local text6 = option.Text

                local name12 = text6

                if not text6 then

                  name12 = option.Name or ""
                end

                id7 = name12
              end

              value21 = id7
            end

            return value21
          else
            return option
          end
        end

        function DropdownElement:_optionText(option)

          for index16, value22 in ipairs(self.Options) do
            local optionValue = self:_optionValue(value22)

            if optionValue == option then
              if (type(value22)) == "table" then
                local text7 = value22.Text

                local name13 = text7

                if not text7 then

                  name13 = value22.Name or optionValue
                end

                return name13
              else
                return tostring(optionValue)
              end
            end
          end

          return tostring(option)
        end

        function DropdownElement:_optionIndex(option)

          for index17, value23 in ipairs(self.Options) do
            if (self:_optionValue(value23)) == option then
              return index17
            end
          end

          return nil
        end

        if DropdownElement.Value == nil and values[1] ~= nil then
          DropdownElement.Value = DropdownElement:_optionValue(values[1])
        end

        if DropdownElement.Value == nil then
          DropdownElement.Value = ""
        end

        local row4, rowLabel4 = self:_row(DropdownElement.Name, opts2.Nested, function(formattedText)
          local DropdownElement2 = DropdownElement
          return formattedText .. ": " .. (DropdownElement:_optionText(DropdownElement.Value))
        end)

        DropdownElement.Row = row4

        function DropdownElement:Set(value, silent)
          local value2 = #self.Options > 0
          local themeValue2 = value2

          if value2 and not (self:_optionIndex(value)) then
            return
          else
            self.Value = value
            rowLabel4.Text = self.Name .. ": " .. (self:_optionText(self.Value))

            if not silent then
              safeCall(self.Callback, self.Value)
            end

            return
          end
        end

        function DropdownElement:Get()
          return self.Value
        end

        row4.InputBegan:Connect(function(input7)

          local userInputType = input7.UserInputType == Enum.UserInputType.MouseButton1
            or input7.UserInputType == Enum.UserInputType.Touch

          local dropdownA, dropdownB, dropdownC, optionIndex

          if userInputType then
            if #DropdownElement.Options == 0 then
              return
            else
              dropdownA = DropdownElement
              optionIndex = DropdownElement:_optionIndex(DropdownElement.Value)
              dropdownB = DropdownElement
              dropdownC = DropdownElement
              DropdownElement:Set(DropdownElement:_optionValue(DropdownElement.Options[(optionIndex or 1) % #DropdownElement.Options + 1]))
              return
            end
          else

            return
          end
        end)

        table.insert(self.Controls, DropdownElement)
        table.insert(self.Window.Controls, DropdownElement)

        self:_attachParent(DropdownElement, DropdownElement.Parent)

        if opts2.Default ~= nil then
          safeCall(DropdownElement.Callback, DropdownElement.Value)
        end

        return DropdownElement
      end

      function Tab.CreateSlider(self, name, min, max, default, callback)
        local spec = ensureTable(name, min, max, default, callback)
        local value = (tonumber(spec.Min)) or 0
        local value2 = (tonumber(spec.Max)) or 100
        local value3 = (tonumber(spec.Step)) or 1

        local id8 = tostring(spec.Id or spec.Name)
        local tostring2 = tostring

        local name14 = tostring2(spec.Name or "Slider")
        local default4 = spec.Default
        local currentValue = default4

        if not default4 then

          currentValue = spec.CurrentValue or value
        end

        local value24 = createSliderTrack(currentValue, value, value2, value3)
        local callback6 = spec.Callback

        local SliderElement = {
          Type = "Slider",
          Id = id8,
          Name = name14,
          Min = value,
          Max = value2,
          Step = value3,
          Value = value24,
          Callback = callback6,
          Module = self,
          Parent = spec.Parent or spec.ParentControl,
        }

        local row3 = self:_row(SliderElement.Name, spec.Nested)
        SliderElement.Row = row3

        local textButton = (createInstance("TextButton", {
          Text = "",
          AutoButtonColor = false,
          Position = (UDim2.new(
            self.Window.IsMobile and 0.38 or 0.42, 0, 0.5,
            -(math.floor(self.Window.SliderHitHeight / 2))
          )),
          Size = (UDim2.new(
            self.Window.IsMobile and 0.44 or 0.38, -42, 0, self.Window.SliderHitHeight
          )),
          BackgroundColor3 = Theme.Track,
          BackgroundTransparency = 1,
          BorderSizePixel = 0,
        }))

        textButton.Parent = row3

        local frame = createInstance("Frame", {
          Position = (UDim2.new(0, 0, 0.5, -2)),
          Size = (UDim2.new(1, 0, 0, 4)),
          BackgroundColor3 = Theme.Track,
          BorderSizePixel = 0,
        }, { addCorner(100) })

        frame.Parent = textButton

        local frame2 = (createInstance("Frame", {
          Size = (UDim2.new(0, 0, 1, 0)),
          BackgroundColor3 = self.Window.Theme.Primary,
          BorderSizePixel = 0,
        }, { addCorner(100) }))

        frame2.Parent = frame

        self.Window:_registerTheme(frame2, "BackgroundColor3", "Primary", nil, true)

        local frame3 = (createInstance("Frame", {
          AnchorPoint = (Vector2.new(0.5, 0.5)),
          Position = (UDim2.new(0, 0, 0.5, 0)),
          Size = (UDim2.new(
            0, self.Window.IsMobile and 13 or 9, 0, self.Window.IsMobile and 13 or 9
          )),
          BackgroundColor3 = self.Window.Theme.Primary,
          BorderSizePixel = 0,
        }, { addCorner(100) }))

        frame3.Parent = textButton

        self.Window:_registerTheme(frame3, "BackgroundColor3", "Primary", nil, true)

        local textBox = (createInstance("TextBox", {
          Text = (formatNumber(SliderElement.Value)),
          ClearTextOnFocus = false,
          Position = (UDim2.new(1, -68, 0, 0)),
          Size = (UDim2.new(0, 60, 1, 0)),
          BackgroundColor3 = (Color3.fromRGB(255, 255, 255)),
          BackgroundTransparency = 1,
          BorderColor3 = self.Window.Theme.Primary,
          BorderSizePixel = 0,
          TextColor3 = Theme.Text,
          TextSize = (getThemeColor("ValueBox")),
          Font = builderSans,
          TextXAlignment = Enum.TextXAlignment.Center,
        }, { addCorner(3) }))

        textBox.Parent = row3

        function SliderElement:_render()
          local value = (self.Value - self.Min) / (math.max(self.Max - self.Min, 0.001))

          tweenTo(frame2, { Size = (UDim2.new(value, 0, 1, 0)) }, 0.15)
          tweenTo(frame3, { Position = (UDim2.new(value, 0, 0.5, 0)) }, 0.15)

          textBox.Text = formatNumber(self.Value)
          return
        end

        function SliderElement:Set(value, silent)

          self.Value = createSliderTrack(value, self.Min, self.Max, self.Step)
          self:_render()

          if not silent then
            safeCall(self.Callback, self.Value)
          end

          return
        end

        function SliderElement:Get()
          return self.Value
        end

        local flag = false

        local function clampSliderX(mouseX)
          local max = math.max(textButton.AbsoluteSize.X, 1)
          local clamp = math.clamp((mouseX - textButton.AbsolutePosition.X) / max, 0, 1)
          SliderElement:Set(SliderElement.Min + clamp * (SliderElement.Max - SliderElement.Min))
          return
        end

        textButton.InputBegan:Connect(function(input8)

          if input8.UserInputType == Enum.UserInputType.MouseButton1
            or input8.UserInputType == Enum.UserInputType.Touch then
            flag = true
            clampSliderX(input8.Position.X)
          end

          return
        end)

        userInputService.InputChanged:Connect(function(input9)
          local dragging = flag
          local isMouseMove = dragging

          if dragging then

            isMouseMove = input9.UserInputType == Enum.UserInputType.MouseMovement
              or input9.UserInputType == Enum.UserInputType.Touch
          end

          if isMouseMove then
            clampSliderX(input9.Position.X)
          end

          return
        end)

        userInputService.InputEnded:Connect(function(input10)

          if input10.UserInputType == Enum.UserInputType.MouseButton1
            or input10.UserInputType == Enum.UserInputType.Touch then
            flag = false
          end

          return
        end)

        bindFocusEffects(textBox, function(text)
          local result = tonumber(text)

          if result then
            local SliderElement2 = SliderElement
            SliderElement:Set(result)
          else
            local SliderElement3 = SliderElement
            SliderElement:_render()
          end

          return
        end)

        local SliderElement4 = SliderElement
        SliderElement:_render()

        table.insert(self.Controls, SliderElement)
        table.insert(self.Window.Controls, SliderElement)

        self:_attachParent(SliderElement, SliderElement.Parent)

        if spec.Default ~= nil then
          safeCall(SliderElement.Callback, SliderElement.Value)
        end

        return SliderElement
      end

      function Tab.CreateDoubleSlider(self, name, min, max, default, callback)
        local spec = ensureTable(name, min, max, default, callback)
        local value = (tonumber(spec.Min)) or 0
        local value2 = (tonumber(spec.Max)) or 100
        local value3 = (tonumber(spec.Step)) or 1
        local default5 = spec.Default
        local currentValue2 = default5

        if not default5 then

          currentValue2 = spec.CurrentValue or { value, value2 }
        end

        local sliderTrack = createSliderTrack(currentValue2[1] or value, value, value2, value3)
        local createSliderTrack2 = createSliderTrack

        local sliderTrack2 = createSliderTrack(currentValue2[2] or value2, value, value2, value3)

        if sliderTrack > sliderTrack2 then
          local sliderTrackA = sliderTrack

          sliderTrack = sliderTrack2
          sliderTrack2 = sliderTrackA
        end

        local id9 = tostring(spec.Id or spec.Name)
        local tostring2 = tostring

        local name15 = tostring2(spec.Name or "DoubleSlider")
        local callback7 = spec.Callback

        local InputElement = {
          Type = "DoubleSlider",
          Id = id9,
          Name = name15,
          Min = value,
          Max = value2,
          Step = value3,
          Low = sliderTrack,
          High = sliderTrack2,
          Callback = callback7,
          Module = self,
          Parent = spec.Parent or spec.ParentControl,
        }

        local row4 = self:_row(InputElement.Name, spec.Nested)
        InputElement.Row = row4

        local textButton = (createInstance("TextButton", {
          Text = "",
          AutoButtonColor = false,
          Position = (UDim2.new(
            self.Window.IsMobile and 0.38 or 0.42, 0, 0.5,
            -(math.floor(self.Window.SliderHitHeight / 2))
          )),
          Size = (UDim2.new(
            self.Window.IsMobile and 0.44 or 0.38, -42, 0, self.Window.SliderHitHeight
          )),
          BackgroundColor3 = Theme.Track,
          BackgroundTransparency = 1,
          BorderSizePixel = 0,
        }))

        textButton.Parent = row4

        local frame = createInstance("Frame", {
          Position = (UDim2.new(0, 0, 0.5, -2)),
          Size = (UDim2.new(1, 0, 0, 4)),
          BackgroundColor3 = Theme.Track,
          BorderSizePixel = 0,
        }, { addCorner(100) })

        frame.Parent = textButton

        local value4 = (createInstance(
          "Frame", { BackgroundColor3 = self.Window.Theme.Primary, BorderSizePixel = 0 },
          { addCorner(100) }
        ))

        value4.Parent = frame

        self.Window:_registerTheme(value4, "BackgroundColor3", "Primary", nil, true)

        local frame2 = (createInstance("Frame", {
          AnchorPoint = (Vector2.new(0.5, 0.5)),
          Size = (UDim2.new(
            0, self.Window.IsMobile and 13 or 9, 0, self.Window.IsMobile and 13 or 9
          )),
          BackgroundColor3 = self.Window.Theme.Primary,
          BorderSizePixel = 0,
        }, { addCorner(100) }))

        frame2.Parent = textButton

        self.Window:_registerTheme(frame2, "BackgroundColor3", "Primary", nil, true)

        local frame3 = (createInstance("Frame", {
          AnchorPoint = (Vector2.new(0.5, 0.5)),
          Size = (UDim2.new(
            0, self.Window.IsMobile and 13 or 9, 0, self.Window.IsMobile and 13 or 9
          )),
          BackgroundColor3 = self.Window.Theme.Primary,
          BorderSizePixel = 0,
        }, { addCorner(100) }))

        frame3.Parent = textButton

        self.Window:_registerTheme(frame3, "BackgroundColor3", "Primary", nil, true)

        local textBox = (createInstance("TextBox", {
          Text = "",
          ClearTextOnFocus = false,
          Position = (UDim2.new(1, -82, 0, 0)),
          Size = (UDim2.new(0, 74, 1, 0)),
          BackgroundColor3 = (Color3.fromRGB(255, 255, 255)),
          BackgroundTransparency = 1,
          BorderColor3 = self.Window.Theme.Primary,
          BorderSizePixel = 0,
          TextColor3 = Theme.Text,
          TextSize = (getThemeColor("ValueBox")),
          Font = builderSans,
          TextXAlignment = Enum.TextXAlignment.Center,
        }, { addCorner(3) }))

        textBox.Parent = row4

        function InputElement:_render()
          local max = math.max(self.Max - self.Min, 0.001)
          local value = (self.Low - self.Min) / max
          local value2 = (self.High - self.Min) / max

          tweenTo(value4, {
            Position = (UDim2.new(value, 0, 0, 0)),
            Size = (UDim2.new(value2 - value, 0, 1, 0)),
          }, 0.15)

          tweenTo(frame2, { Position = (UDim2.new(value, 0, 0.5, 0)) }, 0.15)
          tweenTo(frame3, { Position = (UDim2.new(value2, 0, 0.5, 0)) }, 0.15)

          textBox.Text = (formatNumber(self.Low)) .. " " .. (formatNumber(self.High))
          return
        end

        function InputElement:Set(value, silent)

          if (type(value)) ~= "table" then
            return
          else
            local sliderTrack = createSliderTrack(value[1], self.Min, self.Max, self.Step)

            local sliderTrack2 = createSliderTrack(value[2], self.Min, self.Max, self.Step)

            if sliderTrack > sliderTrack2 then
              local sliderTrackB = sliderTrack2

              sliderTrack2 = sliderTrack
              sliderTrack = sliderTrackB
            end

            self.Low = sliderTrack
            self.High = sliderTrack2
            self:_render()

            if not silent then
              safeCall(self.Callback, self.Low, self.High)
            end

            return
          end
        end

        function InputElement:Get()
          return { self.Low, self.High }
        end

        local function clampSliderX2(mouseX)
          local max = math.max(textButton.AbsoluteSize.X, 1)
          local clamp = math.clamp((mouseX - textButton.AbsolutePosition.X) / max, 0, 1)
          return InputElement.Min + clamp * (InputElement.Max - InputElement.Min)
        end

        local kind

        local function applySliderInput(value)
          local result = clampSliderX2(value)

          if kind == "Low" then
            InputElement:Set({ result, InputElement.High })
          else
            local InputElement2 = InputElement
            InputElement:Set({ InputElement.Low, result })
          end

          return
        end

        textButton.InputBegan:Connect(function(input11)

          local userInputType = input11.UserInputType == Enum.UserInputType.MouseButton1
            or input11.UserInputType == Enum.UserInputType.Touch

          if userInputType then

            local result = clampSliderX2(input11.Position.X)

            kind = (math.abs(result - InputElement.Low)) <= (math.abs(result - InputElement.High)) and "Low"
              or "High"

            applySliderInput(input11.Position.X)
          end

          return
        end)

        userInputService.InputChanged:Connect(function(input12)
          local isMouseMove2 = kind

          if kind then

            isMouseMove2 = input12.UserInputType == Enum.UserInputType.MouseMovement
              or input12.UserInputType == Enum.UserInputType.Touch
          end

          if isMouseMove2 then
            applySliderInput(input12.Position.X)
          end

          return
        end)

        userInputService.InputEnded:Connect(function(input13)

          if input13.UserInputType == Enum.UserInputType.MouseButton1
            or input13.UserInputType == Enum.UserInputType.Touch then
            kind = nil
          end

          return
        end)

        bindFocusEffects(textBox, function(text)
          local tbl = {}

          for match in string.gmatch(text, "[-%d%.]+") do
            table.insert(tbl, tonumber(match))
          end

          if #tbl >= 2 then
            InputElement:Set({ tbl[1], tbl[2] })
          else
            local InputElement2 = InputElement
            InputElement:_render()
          end

          return
        end)

        local InputElement3 = InputElement
        InputElement:_render()

        table.insert(self.Controls, InputElement)
        table.insert(self.Window.Controls, InputElement)

        self:_attachParent(InputElement, InputElement.Parent)

        if spec.Default ~= nil then
          safeCall(InputElement.Callback, InputElement.Low, InputElement.High)
        end

        return InputElement
      end

      function Tab.CreateColorPicker(self, name, default, callback)

        local opts = (type(name)) == "table" and name
          or { Name = name, Default = default, Callback = callback }

        local opts8 = opts
        local color2 = opts.Color
        local default6 = color2

        if not color2 then

          default6 = opts.Default or opts.CurrentValue
        end

        local resolveColor2 = resolveColor
        local value25 = resolveColor(default6, Color3.fromRGB(56, 189, 248))

        local id10 = tostring(opts.Id or opts.Name)
        local tostring2 = tostring

        local name16 = tostring2(opts.Name or "Color")
        local callback8 = opts.Callback
        local self2 = self

        local parent = opts.Parent or opts.ParentControl

        local ColorPickerElement = {
          Type = "ColorPicker",
          Id = id10,
          Name = name16,
          Value = value25,
          Callback = callback8,
          Module = self,
          Parent = parent,
          Opened = opts.Open == true or opts.Opened == true,
          ExtraRows = {},
        }

        local self3 = self
        local row5, rowLabel5 = self:_row(ColorPickerElement.Name, opts.Nested)
        ColorPickerElement.Row = row5

        local value = (fitTextSize({
          Text = (rgbToHex(ColorPickerElement.Value)),
          Position = (UDim2.new(1, -104, 0, 0)),
          Size = (UDim2.new(0, 66, 1, 0)),
          TextSize = (getThemeColor("HexLabel")),
          Font = builderSans,
          Color = Theme.SubText,
          X = Enum.TextXAlignment.Right,
        }))

        value.Parent = row5

        local textButton = (createInstance("TextButton", {
          Text = "",
          AutoButtonColor = false,
          Position = (UDim2.new(1, -28, 0.5, -7)),
          Size = (UDim2.new(0, 18, 0, 14)),
          BackgroundColor3 = ColorPickerElement.Value,
          BorderColor3 = Theme.Border,
          BorderSizePixel = 1,
        }, { addCorner(2) }))

        local textButton3 = textButton
        textButton.Parent = row5
        local isMobile4 = self.Window.IsMobile and 94 or 82
        local new2 = UDim2.new

        local SectionElement = (createInstance("Frame", {
          Size = (new2(1, 0, 0, ColorPickerElement.Opened and isMobile4 or 0)),
          BackgroundColor3 = Theme.Track,
          BorderColor3 = Theme.Border,
          BorderSizePixel = 1,
          Visible = ColorPickerElement.Opened,
          ClipsDescendants = true,
        }, { (addCorner(5)), addPadding(7, 7, 7, 7) }))

        SectionElement:SetAttribute("OpenHeight", isMobile4)
        local SectionElement2 = SectionElement

        SectionElement:SetAttribute("Opened", ColorPickerElement.Opened)
        SectionElement.Parent = self.Body

        table.insert(ColorPickerElement.ExtraRows, SectionElement)
        local isMobile5 = self.Window.IsMobile and 58 or 48

        local imageButton = (createInstance("ImageButton", {
          Size = (UDim2.new(1, 0, 0, isMobile5)),
          BackgroundColor3 = (Color3.fromRGB(255, 0, 0)),
          BorderSizePixel = 0,
          Image = "rbxassetid://4155801252",
          AutoButtonColor = false,
        }, { addCorner(3) }))

        imageButton.Parent = SectionElement

        local textButton2 = (createInstance("TextButton", {
          Text = "",
          AutoButtonColor = false,
          Size = (UDim2.new(1, 0, 0, self.Window.IsMobile and 16 or 12)),
          Position = (UDim2.new(0, 0, 0, isMobile5 + 8)),
          BackgroundColor3 = (Color3.fromRGB(255, 255, 255)),
          BorderSizePixel = 0,
        }, {
          (addCorner(100)),
          createInstance("UIGradient", {
            Color = (ColorSequence.new({
              (ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0))),
              (ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0))),
              (ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0))),
              (ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255))),
              (ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255))),
              (ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255))),
              ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
            })),
          }),
        }))

        textButton2.Parent = SectionElement

        local frame = (createInstance("Frame", {
          AnchorPoint = (Vector2.new(0.5, 0.5)),
          Size = (UDim2.new(0, 8, 0, 8)),
          BackgroundColor3 = (Color3.fromRGB(255, 255, 255)),
          BorderColor3 = (Color3.fromRGB(0, 0, 0)),
          BorderSizePixel = 1,
        }, { addCorner(100) }))

        frame.Parent = imageButton

        local frame2 = (createInstance("Frame", {
          AnchorPoint = (Vector2.new(0.5, 0.5)),
          Size = (UDim2.new(0, 5, 1, 4)),
          Position = (UDim2.new(0, 0, 0.5, 0)),
          BackgroundColor3 = (Color3.fromRGB(255, 255, 255)),
          BorderColor3 = (Color3.fromRGB(0, 0, 0)),
          BorderSizePixel = 1,
        }, { addCorner(100) }))

        frame2.Parent = textButton2

        local hue, saturation, brightness = ColorPickerElement.Value:ToHSV()
        local flag = false
        local flag2 = false

        local function updateColorFromHsv()
          ColorPickerElement.Value = Color3.fromHSV(hue, saturation, brightness)
          imageButton.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
          textButton.BackgroundColor3 = ColorPickerElement.Value
          value.Text = rgbToHex(ColorPickerElement.Value)
          frame.Position = UDim2.new(saturation, 0, 1 - brightness, 0)
          frame2.Position = UDim2.new(hue, 0, 0.5, 0)
          return
        end

        local function fireColorCallback()
          safeCall(ColorPickerElement.Callback, ColorPickerElement.Value)
          return
        end

        local function setColorPickerOpened(opened)
          ColorPickerElement.Opened = opened == true
          SectionElement:SetAttribute("Opened", ColorPickerElement.Opened)
          local SectionElement2 = SectionElement

          SectionElement.Visible = ColorPickerElement.Opened and ColorPickerElement.Visible ~= false
          local SectionElement3 = SectionElement
          local SectionElement4 = SectionElement
          local visible5 = SectionElement.Visible

          local udim15 = visible5
          udim15 = visible5 and UDim2.new(1, 0, 0, isMobile4)

          SectionElement.Size = udim15 or UDim2.new(1, 0, 0, 0)
          self:_refreshBodyHeight()
          return
        end

        local function onColorPickerDragBegin(input)

          local clamp = math.clamp(
            input.Position.X - imageButton.AbsolutePosition.X, 0, imageButton.AbsoluteSize.X
          )

          local clamp = math.clamp

          local y2 = input.Position.Y

          local y3 = imageButton.AbsolutePosition.Y
          local imageButton2 = imageButton

          local y4 = imageButton.AbsoluteSize.Y
          local result = clamp(y2 - y3, 0, y4)
          saturation = clamp / (math.max(imageButton.AbsoluteSize.X, 1))
          brightness = 1 - result / (math.max(imageButton.AbsoluteSize.Y, 1))
          updateColorFromHsv()
          fireColorCallback()
          return
        end

        local function onColorPickerDrag(input)
          hue = (math.clamp(input.Position.X - textButton2.AbsolutePosition.X, 0, textButton2.AbsoluteSize.X))
            / (math.max(textButton2.AbsoluteSize.X, 1))

          updateColorFromHsv()
          fireColorCallback()
          return
        end

        textButton.MouseButton1Click:Connect(function()
          setColorPickerOpened(not ColorPickerElement.Opened)
          return
        end)

        imageButton.InputBegan:Connect(function(input14)

          if input14.UserInputType == Enum.UserInputType.MouseButton1
            or input14.UserInputType == Enum.UserInputType.Touch then
            flag = true
            onColorPickerDragBegin(input14)
          end

          return
        end)

        textButton2.InputBegan:Connect(function(input15)

          if input15.UserInputType == Enum.UserInputType.MouseButton1
            or input15.UserInputType == Enum.UserInputType.Touch then
            flag2 = true
            onColorPickerDrag(input15)
          end

          return
        end)

        userInputService.InputEnded:Connect(function(input16)

          if input16.UserInputType == Enum.UserInputType.MouseButton1
            or input16.UserInputType == Enum.UserInputType.Touch then
            flag = false
            flag2 = false
          end

          return
        end)

        userInputService.InputChanged:Connect(function(input17)

          if input17.UserInputType == Enum.UserInputType.MouseMovement
            or input17.UserInputType == Enum.UserInputType.Touch then
            if flag then
              onColorPickerDragBegin(input17)
            else
              if flag2 then
                onColorPickerDrag(input17)
              end
            end
          end

          return
        end)

        function ColorPickerElement:Set(color, silent)
          self.Value = resolveColor(color, self.Value)

          local hsvOut
          hue, saturation, hsvOut = self.Value:ToHSV()
          brightness = hsvOut
          updateColorFromHsv()

          if not silent then
            fireColorCallback()
          end

          return
        end

        function ColorPickerElement:Get()
          return colorToRgbTable(self.Value)
        end

        function ColorPickerElement:GetColor()
          return self.Value
        end

        updateColorFromHsv()

        table.insert(self.Controls, ColorPickerElement)
        table.insert(self.Window.Controls, ColorPickerElement)

        local self4 = self
        self:_attachParent(ColorPickerElement, ColorPickerElement.Parent)

        if opts.Default ~= nil then
          safeCall(ColorPickerElement.Callback, ColorPickerElement.Value)
        end

        return ColorPickerElement
      end

      textButton.MouseButton1Click:Connect(function()
        local Tab5 = Tab
        Tab:Set(not Tab.Enabled)
        return
      end)

      textButton.InputBegan:Connect(function(input18)
        if input18.UserInputType == Enum.UserInputType.MouseButton2 then
          local Tab6 = Tab
          Tab:SetExpanded(not Tab.Expanded)
        end

        return
      end)

      textButton2.MouseButton1Click:Connect(function()
        local Tab7 = Tab
        Tab:SetExpanded(not Tab.Expanded)
        return
      end)

      frame.MouseEnter:Connect(function()
        frame.BackgroundColor3 = Theme.CardHover
        return
      end)

      frame.MouseLeave:Connect(function()
        frame.BackgroundColor3 = Theme.Card
        return
      end)

      table.insert(self.Modules, Tab)
      table.insert(self.Window.Modules, Tab)

      if self.Window.ActiveTabName == self.Name then
        frame.Parent = self.Window.List
      else
        frame.Parent = nil
      end

      if Tab.Enabled then
        createButton(
          Tab.TitleLabel, self.Window.Theme.Primary, self.Window.Theme.Accent, nil, self.Window
        )

        safeCall(Tab.Callback, true)
      end

      return Tab
    end

    local value3 = not self.FirstTabName
    local isNotSearch1 = value3

    if value3 then

      isNotSearch1 = kind2 ~= "Search" and kind2 ~= "Themes"
    end

    if isNotSearch1 then
      self.FirstTabName = value
    end

    local value4 = not self.ActiveTabName
    local isNotSearch2 = value4

    if value4 then

      isNotSearch2 = kind2 ~= "Search" and kind2 ~= "Themes"
    end

    if isNotSearch2 then
      local self3 = self
      self:SelectTab(value)
    end

    return Module
  end

  function Window:_collectConfig()
    local tbl = { Theme = self.ThemeName, Modules = {} }

    if self.CustomTheme then
      tbl.CustomTheme = {
        Primary = (colorToRgbTable(self.CustomTheme.Primary)),
        Accent = (colorToRgbTable(self.CustomTheme.Accent)),
      }
    end

    for index18, value26 in ipairs(self.Modules) do
      local tbl2 = { Enabled = value26.Enabled, Controls = {} }

      for index19, value27 in ipairs(value26.Controls) do
        tbl2.Controls[value27.Id] = value27:Get()
      end

      tbl.Modules[value26.Id] = tbl2
    end

    return tbl
  end

  function Window.SaveConfig(self, name)
    local value = name or "default"
    local configValue2 = value
    local jsonEncode = httpService:JSONEncode(self:_collectConfig())
    local writefile = getGlobal("writefile")
    local makefolder = getGlobal("makefolder")

    if (typeof(writefile)) == "function" then
      if (typeof(makefolder)) == "function" then
        pcall(makefolder, "Rise")
        pcall(makefolder, self.ConfigFolder)
      end

      writefile(self.ConfigFolder .. "/" .. value .. ".json", jsonEncode)
    else
      local g4 = _G

      g4.RiseLibConfigs = _G.RiseLibConfigs or {}
      _G.RiseLibConfigs[value] = jsonEncode
    end

    return true
  end

  function Window.LoadConfig(self, name)
    local value = name or "default"
    local configValue3 = value
    local readfile = getGlobal("readfile")
    local isfile = getGlobal("isfile")
    local configFolder = self.ConfigFolder .. "/" .. value .. ".json"
    local value2 = (typeof(readfile)) == "function"
    local configExists = value2

    if value2 then
      local value3 = (typeof(isfile)) == "function"

      local configPath = value3

      configExists = value3 and isfile(configFolder)
    end

    local configContent

    if configExists then
      configContent = (readfile(configFolder))
    else
      if _G.RiseLibConfigs then
        configContent = _G.RiseLibConfigs[value]
      end
    end

    if not configContent then
      return false
    else
      local tbl = {
        pcall(function()
          return httpService:JSONDecode(configContent)
        end),
      }

      local value4 = tbl[2]

      if not tbl[1] or (type(value4)) ~= "table" then
        return false
      else
        if value4.CustomTheme then
          self:SetCustomTheme(value4.CustomTheme.Primary, value4.CustomTheme.Accent)
        else
          if value4.Theme then
            self:SetTheme(value4.Theme)
          end
        end

        for index20, value28 in ipairs(self.Modules) do

          local modules2 = value4.Modules and value4.Modules[value28.Id]

          if modules2 then
            value28:Set(modules2.Enabled, true)

            for index21, value29 in ipairs(value28.Controls) do

              local controls2 = modules2.Controls and modules2.Controls[value29.Id]

              if controls2 ~= nil then
                value29:Set(controls2, true)
              end
            end
          end
        end

        for index22, value30 in ipairs(self.Modules) do

          local modules3 = value4.Modules and value4.Modules[value30.Id]

          if modules3 then
            safeCall(value30.Callback, modules3.Enabled)

            for index23, value31 in ipairs(value30.Controls) do

              local controls3 = modules3.Controls and modules3.Controls[value31.Id]

              if controls3 ~= nil and value31.Type ~= "Keybind" then
                local getColor = controls3

                if value31.Type == "ColorPicker" and value31.GetColor then
                  getColor = value31:GetColor()
                end

                safeCall(value31.Callback, getColor)
              end
            end
          end
        end

        return true
      end
    end
  end

  function Window:GetConfigs()
    local tbl = {}
    local readfile2 = getGlobal("readfile")
    getGlobal("isfile")
    local listfiles = getGlobal("listfiles")
    local configFolder2 = self.ConfigFolder

    if (typeof(listfiles)) == "function" and (typeof(readfile2)) == "function" then
      local listOk, fileList
      fileList, listOk = pcall(listfiles, configFolder2)

      if fileList and listOk then
        for index24, value32 in ipairs(listOk) do
          if (string.match(value32, "%.json$")) then
            local match = string.match(value32, "([^/\\]+)%.json$")

            if match then
              table.insert(tbl, match)
            end
          end
        end
      end
    else
      if _G.RiseLibConfigs then
        for key4 in pairs(_G.RiseLibConfigs) do
          table.insert(tbl, key4)
        end
      end
    end

    table.sort(tbl)
    return tbl
  end

  function Window.DeleteConfig(self, name)
    local value = name or "Default"
    local configValue4 = value
    local removefile = getGlobal("removefile")

    local delfile = removefile
    delfile = removefile or getGlobal("delfile")

    local configFolder = self.ConfigFolder .. "/" .. value .. ".json"

    if (typeof(delfile)) == "function" then
      local tbl = { pcall(delfile, configFolder) }
      return tbl[1]
    else
      if _G.RiseLibConfigs then
        _G.RiseLibConfigs[value] = nil
        return true
      else
        return false
      end
    end
  end

  function Window:_playerListRefreshFilter()

    local playerListSearchText = self._playerListSearchText or ""

    for key5, value33 in pairs(self._playerListRows) do
      local visible6 = true

      if playerListSearchText ~= "" then

        local getPlayerByUserId = players:GetPlayerByUserId(key5)

        if getPlayerByUserId then
          local lower2 = string.lower

          local displayName = getPlayerByUserId.DisplayName or ""

          local name17 = getPlayerByUserId.Name or ""

          local lower22 = lower2

          local result = lower2(displayName .. " " .. name17)

          visible6 = (string.find(result, playerListSearchText, 1, true)) ~= nil
        else
          visible6 = false
        end
      end

      value33.Row.Visible = visible6
    end

    return
  end

  function Window:_playerListRemovePlayer(player)
    local userId = player and player.UserId
    local playerListRows = self._playerListRows[userId]

    if not playerListRows then
      return
    else

      playerListRows.Row:Destroy()

      self._playerListRows[userId] = nil
      self._playerListStates[userId] = nil
      self:_playerListSyncDeathWatch(userId, nil)

      return
    end
  end

  function Window:_playerListSetButtonState(self, player, state)
    local self2 = self

    if state then
      self.BackgroundTransparency = 1
      self.BackgroundColor3 = Color3.new(1, 1, 1)

      createButton(self, self.Theme.Primary, self.Theme.Accent, nil, self)
      player.TextColor3 = Theme.Text
      tweenTo(self, { BackgroundTransparency = 0 }, 0.4)
    else
      self.BackgroundTransparency = 0
      clearThemeGradient(self, self)
      self.BackgroundColor3 = Theme.Track
      player.TextColor3 = Theme.Muted
    end

    return
  end

  function Window:_playerListSyncDeathWatch(self, player)
    local self2 = self
    local self3 = self

    local playerListDeathWatchers = self._playerListDeathWatchers or {}
    self._playerListDeathWatchers = playerListDeathWatchers
    local playerListDeathWatchers = self._playerListDeathWatchers[self]
    local characterAdded, connect, getPlayerByUserId2, playerListCallbacks, onCharacterAdded

    if player == "Blacklist" then
      if playerListDeathWatchers then
        return
      else

        getPlayerByUserId2 = (players:GetPlayerByUserId(self))

        if not getPlayerByUserId2 then
          return
        else
          playerListCallbacks = {}
          self._playerListDeathWatchers[self] = playerListCallbacks

          function onCharacterAdded(self)

            if not self then
              return
            else
              local humanoid = self:FindFirstChildOfClass("Humanoid")

              if humanoid then
                local died = humanoid.Died

                local connect2 = died:Connect(function()
                  local self2 = self

                  self:Notify({
                    Title = "Blacklist Player",
                    Content = getPlayerByUserId2.Name .. " Died",
                    Duration = 2.5,
                  })

                  return
                end)

                table.insert(playerListCallbacks, connect2)
              end

              return
            end
          end

          if getPlayerByUserId2.Character then
            onCharacterAdded(getPlayerByUserId2.Character)
          end

          characterAdded = getPlayerByUserId2.CharacterAdded

          connect = characterAdded:Connect(function(character)
            local self4 = self

            self:Notify({
              Title = "Blacklist Player",
              Content = getPlayerByUserId2.Name .. " Respawned",
              Duration = 2.5,
            })

            onCharacterAdded(character)
            return
          end)

          table.insert(playerListCallbacks, connect)
          return
        end
      end
    else
      if playerListDeathWatchers then
        for index25, value34 in ipairs(playerListDeathWatchers) do
          value34:Disconnect()
        end

        self._playerListDeathWatchers[self] = nil
      end

      return
    end
  end

  function Window:_playerListAddPlayer(player)
    local userId2 = player.UserId

    local playerListConfig, name18, imageLabel, textButton4, textLabel, textButton5, textLabel2, textButton6, textLabel3, textButton7, textLabel4, syncPlayerListState

    if self._playerListRows[userId2] then
      return
    else

      playerListConfig = self._playerListConfig or {}

      if not playerListConfig.IncludeLocalPlayer and player == players.LocalPlayer then
        return
      else
        local isMobile6 = self.IsMobile and 42 or 50

        local isMobile7 = self.IsMobile and 28 or 36

        local isMobile8 = self.IsMobile and 22 or 26

        local isMobile9 = self.IsMobile and 46 or 54

        local floor = math.floor((isMobile6 - isMobile7) / 2)

        local floor2 = math.floor((isMobile6 - isMobile8) / 2)

        local frame = createInstance("Frame", {
          Size = (UDim2.new(1, 0, 0, isMobile6)),
          BackgroundColor3 = Theme.Card,
          BorderColor3 = Theme.Border,
          BorderSizePixel = 1,
        }, { addCorner(8) })

        frame.Parent = self._playerListFrame

        imageLabel = (createInstance("ImageLabel", {
          Position = (UDim2.new(0, 8, 0, floor)),
          Size = (UDim2.new(0, isMobile7, 0, isMobile7)),
          BackgroundColor3 = Theme.Track,
          BorderSizePixel = 0,
          Image = "",
        }, { addCorner(math.floor(isMobile7 / 2)) }))

        imageLabel.Parent = frame

        task.spawn(function()

          for k = 1, 8 do
            if not imageLabel.Parent then
              return
            else
              local tbl = {
                pcall(function()

                  return players:GetUserThumbnailAsync(
                    player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100
                  )
                end),
              }

              local value = tbl[1]

              local hasValue = value

              local value2 = tbl[2]

              if value then

                hasValue = (typeof(value2)) == "string" and value2 ~= ""
              end

              if hasValue then
                imageLabel.Image = value2
                return
              else
                task.wait(0.5)
              end
            end
          end

          return
        end)

        if player.DisplayName ~= "" and player.DisplayName ~= player.Name then
          name18 = player.DisplayName .. " (@" .. player.Name .. ")"
        else
          name18 = player.Name
        end

        local result = fitTextSize({
          Text = name18,
          Position = (UDim2.new(0, isMobile7 + 16, 0, 0)),
          Size = (UDim2.new(1, -(isMobile7 + 16 + isMobile9 * 4 + 38), 1, 0)),
          TextSize = (getThemeColor("PlayerName", self.IsMobile)),
          Font = builderSans,
          Color = Theme.Text,
          X = Enum.TextXAlignment.Left,
          Truncate = Enum.TextTruncate.AtEnd,
        })

        result.Parent = frame

        textButton4 = (createInstance("TextButton", {
          Text = "",
          AnchorPoint = (Vector2.new(1, 0)),
          Position = (UDim2.new(1, -(isMobile9 + 8), 0, floor2)),
          Size = (UDim2.new(0, isMobile9, 0, isMobile8)),
          AutoButtonColor = false,
          BackgroundColor3 = Theme.Track,
          BorderSizePixel = 0,
          ZIndex = 2,
        }, { addCorner(5) }))

        textButton4.Parent = frame

        textLabel = (createInstance("TextLabel", {
          Text = playerListConfig.BlacklistText or "Blacklist",
          Size = (UDim2.new(1, 0, 1, 0)),
          BackgroundTransparency = 1,
          TextColor3 = Theme.Muted,
          TextSize = (getThemeColor("PlayerActionButton", self.IsMobile)),
          Font = builderSans,
          ZIndex = 3,
        }))

        textLabel.Parent = textButton4

        textButton5 = (createInstance("TextButton", {
          Text = "",
          AnchorPoint = (Vector2.new(1, 0)),
          Position = (UDim2.new(1, -(isMobile9 * 3 + 20), 0, floor2)),
          Size = (UDim2.new(0, isMobile9, 0, isMobile8)),
          AutoButtonColor = false,
          BackgroundColor3 = Theme.Track,
          BorderSizePixel = 0,
          ZIndex = 2,
        }, { addCorner(5) }))

        textButton5.Parent = frame

        local createInstance2 = createInstance

        textLabel2 = (createInstance("TextLabel", {
          Text = playerListConfig.WhitelistText or "Whitelist",
          Size = (UDim2.new(1, 0, 1, 0)),
          BackgroundTransparency = 1,
          TextColor3 = Theme.Muted,
          TextSize = (getThemeColor("PlayerActionButton", self.IsMobile)),
          Font = builderSans,
          ZIndex = 3,
        }))

        textLabel2.Parent = textButton5

        textButton6 = (createInstance("TextButton", {
          Text = "",
          AnchorPoint = (Vector2.new(1, 0)),
          Position = (UDim2.new(1, -8, 0, floor2)),
          Size = (UDim2.new(0, isMobile9, 0, isMobile8)),
          AutoButtonColor = false,
          BackgroundColor3 = Theme.Track,
          BorderSizePixel = 0,
          ZIndex = 2,
        }, { addCorner(5) }))

        textButton6.Parent = frame

        local createInstance3 = createInstance

        textLabel3 = (createInstance("TextLabel", {
          Text = playerListConfig.BringText or "Bring",
          Size = (UDim2.new(1, 0, 1, 0)),
          BackgroundTransparency = 1,
          TextColor3 = Theme.Muted,
          TextSize = (getThemeColor("PlayerActionButton", self.IsMobile)),
          Font = builderSans,
          ZIndex = 3,
        }))

        textLabel3.Parent = textButton6

        textButton7 = (createInstance("TextButton", {
          Text = "",
          AnchorPoint = (Vector2.new(1, 0)),
          Position = (UDim2.new(1, -(isMobile9 * 4 + 28), 0, floor2)),
          Size = (UDim2.new(0, isMobile9, 0, isMobile8)),
          AutoButtonColor = false,
          BackgroundColor3 = Theme.Track,
          BorderSizePixel = 0,
          ZIndex = 2,
        }, { addCorner(5) }))

        textButton7.Parent = frame

        local createInstance4 = createInstance

        textLabel4 = (createInstance("TextLabel", {
          Text = playerListConfig.LoopTpText or "LoopTp",
          Size = (UDim2.new(1, 0, 1, 0)),
          BackgroundTransparency = 1,
          TextColor3 = Theme.Muted,
          TextSize = (getThemeColor("PlayerActionButton", self.IsMobile)),
          Font = builderSans,
          ZIndex = 3,
        }))

        textLabel4.Parent = textButton7

        function syncPlayerListState()
          local playerListStates = self._playerListStates[userId2]
          self:_playerListSetButtonState(textButton4, textLabel, playerListStates == "Blacklist")
          local self2 = self
          self:_playerListSetButtonState(textButton5, textLabel2, playerListStates == "Whitelist")
          local self3 = self

          local playerListBring = self._playerListBring and self._playerListBring[userId2]
          local self4 = self
          self:_playerListSetButtonState(textButton6, textLabel3, playerListBring)
          local self5 = self

          local playerListLoopTp = self._playerListLoopTp and self._playerListLoopTp[userId2]
          local self6 = self
          self:_playerListSetButtonState(textButton7, textLabel4, playerListLoopTp)
          local self7 = self
          self:_playerListSyncDeathWatch(userId2, playerListStates)
          return
        end

        textButton4.MouseButton1Click:Connect(function()
          if self._playerListStates[userId2] == "Blacklist" then
            self._playerListStates[userId2] = nil
          else
            self._playerListStates[userId2] = "Blacklist"
          end

          syncPlayerListState()

          safeCall(playerListConfig.StateChanged, {
            Player = player,
            State = self._playerListStates[userId2],
          })

          return
        end)

        textButton5.MouseButton1Click:Connect(function()
          if self._playerListStates[userId2] == "Whitelist" then
            self._playerListStates[userId2] = nil
          else
            self._playerListStates[userId2] = "Whitelist"
          end

          syncPlayerListState()

          safeCall(playerListConfig.StateChanged, {
            Player = player,
            State = self._playerListStates[userId2],
          })

          return
        end)

        textButton6.MouseButton1Click:Connect(function()
          self._playerListBring[userId2] = not self._playerListBring[userId2]
          syncPlayerListState()
          return
        end)

        textButton7.MouseButton1Click:Connect(function()
          self._playerListLoopTp[userId2] = not self._playerListLoopTp[userId2]
          syncPlayerListState()
          return
        end)

        self._playerListRows[userId2] = {
          Row = frame,
          NameLabel = result,
          BlackBtn = textButton4,
          BlackLabel = textLabel,
          WhiteBtn = textButton5,
          WhiteLabel = textLabel2,
          BringBtn = textButton6,
          BringLabel = textLabel3,
          LoopTpBtn = textButton7,
          LoopTpLabel = textLabel4,
          Refresh = syncPlayerListState,
        }

        syncPlayerListState()

        local self2 = self

        self:_playerListRefreshFilter()
        return
      end
    end
  end

  function Window:_renderPlayerList()
    local self2 = self
    self:_clear()

    if self._playerListUIConnections then
      for index26, value35 in ipairs(self._playerListUIConnections) do
        value35:Disconnect()
      end
    end

    self._playerListUIConnections = {}

    local playerListConfig2 = self._playerListConfig or {}

    local searchPlaceholder = playerListConfig2.SearchPlaceholder or "Search player..."
    local createInstance2 = createInstance

    local textBox = (createInstance("TextBox", {
      Text = "",
      PlaceholderText = searchPlaceholder,
      Size = (UDim2.new(1, 0, 0, 36)),
      BackgroundColor3 = Theme.Track,
      BorderColor3 = Theme.Border,
      BorderSizePixel = 1,
      TextColor3 = Theme.Text,
      PlaceholderColor3 = Theme.Muted,
      TextSize = (getThemeColor("PlayerSearchBox")),
      Font = builderSans,
      TextXAlignment = Enum.TextXAlignment.Left,
      ClearTextOnFocus = false,
    }, { (addCorner(7)), addPadding(10, 0, 10, 0) }))

    textBox.Parent = self.List

    self._playerListSearchBox = textBox

    local scrollingFrame = createInstance("ScrollingFrame", {
      Name = "PlayerListFrame",
      BackgroundTransparency = 1,
      Size = (UDim2.new(1, 0, 1, -44)),
      Position = (UDim2.new(0, 0, 0, 44)),
      BorderSizePixel = 0,
      CanvasSize = (UDim2.new(0, 0, 0, 0)),
      AutomaticCanvasSize = Enum.AutomaticSize.Y,
      ScrollBarThickness = 2,
      ScrollBarImageColor3 = (Color3.fromRGB(255, 255, 255)),
      ScrollBarImageTransparency = 0.88,
    }, {
      createInstance("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = (UDim.new(0, 6)),
      }),
    })

    scrollingFrame.Parent = self.List

    self._playerListFrame = scrollingFrame
    self._playerListRows = {}

    local textBox2 = textBox
    local text8 = textBox:GetPropertyChangedSignal("Text")

    local connect3 = text8:Connect(function()
      self._playerListSearchText = string.lower(textBox.Text)
      local self3 = self
      self:_playerListRefreshFilter()
      return
    end)

    table.insert(self._playerListUIConnections, connect3)

    for index27, value36 in ipairs(players:GetPlayers()) do
      local self4 = self
      self:_playerListAddPlayer(value36)
    end

    return
  end

  function Window.CreatePlayerList(self, config)
    local value = config or {}
    local configValue5 = value
    local self2 = self

    local playerListConnections = self._playerListConnections or {}

    self._playerListConnections = playerListConnections
    local self3 = self

    self._playerListRows = self._playerListRows or {}
    local self4 = self

    self._playerListStates = self._playerListStates or {}
    self._playerListConfig = value
    self._playerListSearchText = ""

    local self5 = self

    self._playerListBring = self._playerListBring or {}

    if self._playerListBringConnection then

      self._playerListBringConnection:Disconnect()
    end

    self._playerListBringConnection = runService.RenderStepped:Connect(function()
      local localPlayer2 = players.LocalPlayer
      local character = localPlayer2 and localPlayer2.Character

      if not character then
        return
      else
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart then
          return
        else
          local cframe = humanoidRootPart.CFrame + humanoidRootPart.CFrame.LookVector * 3

          for key6, value37 in pairs(self._playerListBring) do
            if value37 then

              local getPlayerByUserId3 = players:GetPlayerByUserId(key6)

              if getPlayerByUserId3 then
                local character2 = getPlayerByUserId3.Character

                if character2 then
                  local humanoidRootPart2 = character2:FindFirstChild("HumanoidRootPart")

                  if humanoidRootPart2 then
                    humanoidRootPart2.CFrame = cframe
                  end
                end
              end
            end
          end

          return
        end
      end
    end)

    local self6 = self

    self._playerListLoopTp = self._playerListLoopTp or {}

    if self._playerListLoopTpConnection then

      self._playerListLoopTpConnection:Disconnect()
    end

    self._playerListLoopTpConnection = runService.RenderStepped:Connect(function()
      local localPlayer3 = players.LocalPlayer
      local character3 = localPlayer3 and localPlayer3.Character

      if not character3 then
        return
      else
        local humanoidRootPart3 = character3:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart3 then
          return
        else
          for key7, value38 in pairs(self._playerListLoopTp) do
            if value38 then
              local players2 = players

              local getPlayerByUserId4 = players:GetPlayerByUserId(key7)

              if getPlayerByUserId4 then
                local character4 = getPlayerByUserId4.Character

                if character4 then
                  local humanoidRootPart4 = character4:FindFirstChild("HumanoidRootPart")

                  if humanoidRootPart4 then
                    local position2 = humanoidRootPart4.CFrame.Position

                    local value2 = position2 - (Vector3.new(0, 3, 0))

                    local yAxis = position2 - value2

                    if yAxis.Magnitude < 0.001 then
                      yAxis = Vector3.yAxis
                    end

                    local unit = yAxis.Unit

                    local yAxis2 = Vector3.yAxis

                    if (math.abs(unit:Dot(yAxis2))) > 0.999 then
                      yAxis2 = humanoidRootPart4.CFrame.LookVector
                    end

                    humanoidRootPart3.CFrame = CFrame.lookAt(value2, position2, yAxis2)
                  end
                end
              end
            end
          end

          return
        end
      end
    end)

    local title3 = value.Title
    local name19 = title3

    if not title3 then

      name19 = value.Name or "Player List"
    end

    local self7 = self

    local tabKey = value.TabKey or "tab_playerlist"
    local self8 = self

    local tab = self:CreateTab({ Name = name19, Key = tabKey, Kind = "PlayerList" })

    if self.ActiveTabName == name19 then
      local self9 = self
      self:_renderPlayerList()
    end

    local playerAdded = players.PlayerAdded

    local connect4 = playerAdded:Connect(function(player)

      if self._playerListFrame then
        local self10 = self
        self:_playerListAddPlayer(player)
      end

      return
    end)

    table.insert(self._playerListConnections, connect4)
    local playerRemoving = players.PlayerRemoving

    local connect5 = playerRemoving:Connect(function(player)
      local self11 = self
      self:_playerListRemovePlayer(player)
      return
    end)

    table.insert(self._playerListConnections, connect5)

    return {
      Tab = tab,
      Instance = self._playerListFrame,
      GetState = function(self, key)
        local playerListStates = self._playerListStates

        local value = playerListStates[key and key.UserId]
        local flag = false

        for key8, value39 in pairs(self._playerListStates) do
          if value39 == "Blacklist" then
            flag = true
            break
          end
        end

        return value, flag
      end,
      HasBlacklist = function()
        for key9, value40 in pairs(self._playerListStates) do
          if value40 == "Blacklist" then
            return true
          end
        end

        return false
      end,
      SetState = function(self, player, state)

        local value = not player or player.Parent ~= players

        if value then
          return
        else

          if state == "Whitelist" or state == "Blacklist" then
            self._playerListStates[player.UserId] = state
          else
            self._playerListStates[player.UserId] = nil
          end

          local playerListRows = self._playerListRows[player.UserId]

          if playerListRows and playerListRows.Refresh then
            playerListRows.Refresh()
          end

          safeCall(value.StateChanged, {
            Player = player,
            State = self._playerListStates[player.UserId],
          })

          return
        end
      end,
      Refresh = function()
        if self._playerListFrame then
          self:_renderPlayerList()
        end

        return
      end,
    }
  end

  function Window:Destroy()
    self:_stopGradientAnimation()

    if self.InputConnection then

      self.InputConnection:Disconnect()
      self.InputConnection = nil
    end

    for keybindIndex, keybind in ipairs(self.Keybinds or {}) do
      if keybind.Connection then

        keybind.Connection:Disconnect()
        keybind.Connection = nil
      end
    end

    if self._playerListConnections then
      for index28, value41 in ipairs(self._playerListConnections) do
        value41:Disconnect()
      end

      self._playerListConnections = nil
    end

    if self._playerListUIConnections then
      for index29, value42 in ipairs(self._playerListUIConnections) do
        value42:Disconnect()
      end

      self._playerListUIConnections = nil
    end

    if self._playerListDeathWatchers then
      for key10, value43 in pairs(self._playerListDeathWatchers) do
        for index30, value44 in ipairs(value43) do
          value44:Disconnect()
        end
      end

      self._playerListDeathWatchers = nil
    end

    if self._playerListBringConnection then

      self._playerListBringConnection:Disconnect()
      self._playerListBringConnection = nil
    end

    if self._playerListLoopTpConnection then

      self._playerListLoopTpConnection:Disconnect()
      self._playerListLoopTpConnection = nil
    end

    if self.ScreenGui and self.ScreenGui.Parent then

      self.ScreenGui:Destroy()
    end

    return
  end

  local Window9 = Window

  Window:CreateTab(Window.SearchTab or { Name = "Search", Key = "Search", Kind = "Search" })

  if Window.GradientAnimation ~= false then
    local Window10 = Window
    Window:_startGradientAnimation()
  end

  local frame11 = createInstance("Frame", {
    AnchorPoint = (Vector2.new(0.5, 0)),
    Position = (UDim2.new(0.5, 0, 0, 4)),
    Size = (UDim2.new(0, 200, 0, 38)),
    BackgroundColor3 = (Color3.new(1, 1, 1)),
    BorderSizePixel = 0,
    ZIndex = 5,
  }, { addCorner(19) })

  frame11.Parent = screenGui

  createButton(frame11, Window.Theme.Primary, Window.Theme.Accent, nil, Window)

  local textButton3 = (createInstance("TextButton", {
    Text = "",
    AutoButtonColor = false,
    AnchorPoint = (Vector2.new(0.5, 0)),
    Position = (UDim2.new(0.5, 0, 0, 6)),
    Size = (UDim2.new(0, 196, 0, 34)),
    BackgroundColor3 = (Color3.new(0, 0, 0)),
    BackgroundTransparency = 0.8,
    BorderSizePixel = 0,
    TextColor3 = (Color3.new(1, 1, 1)),
    TextSize = (getThemeColor("Toast")),
    Font = builderSansBold,
    ZIndex = 6,
  }, { (addCorner(17)), addPadding(12, 0, 12, 0) }))

  textButton3.Parent = screenGui

  local tbl2 = {}
  local num = 0
  local num2 = 60
  local statsService = game:GetService("Stats")
  local pingValue = 0
  local lastPingRead = 0

  runService.Heartbeat:Connect(function(delta2)
    table.insert(tbl2, delta2)
    local result4 = tick()

    if result4 - num >= 1 then
      local num3 = 0

      for index31, value45 in ipairs(tbl2) do
        num3 = num3 + value45
      end

      if #tbl2 > 0 then
        num2 = (math.floor(#tbl2 / num3 + 0.5))
      end

      tbl2 = {}
      num = result4
    end

    if #tbl2 > 120 then
      table.remove(tbl2, 1)
    end

    if result4 - lastPingRead >= 0.5 then
      lastPingRead = result4

      local okItem, pingItem = pcall(function()
        return statsService.Network.ServerStatsItem["Data Ping"]
      end)

      if okItem and pingItem then
        local okValue, rawPing = pcall(function()
          return pingItem:GetValue()
        end)

        if okValue then
          local parsed = tonumber(rawPing)
          if parsed then
            pingValue = math.floor(parsed)
          end
        end
      end
    end

    textButton3.Text = Window.Title .. "  ·  FPS: " .. num2 .. "  ·  Ping: " .. pingValue

    return
  end)

  textButton3.MouseButton1Click:Connect(function()
    local Window11 = Window
    Window:Toggle()
    return
  end)

  Window._island = textButton3
  Window._islandBorder = frame11

  table.insert(self._windows, Window)
  return Window
end

function Library.CreateConfigSystem(self)
  local config3, window2

  if self.Tabs then
    window2 = self

    if window2.Tabs.Config then
      config3 = window2.Tabs.Config
    else

      config3 = window2:CreateTab({ Name = "Config", Key = "tab_config", Kind = "CaS" })
    end

    function config3._renderConfigUI()
      local frame = createInstance("Frame", {
        Size = (UDim2.new(1, 0, 0, 66)),
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0,
      }, { addCorner(7) })

      frame.Parent = window2.List

      ;(fitTextSize({
        Text = "Configs",
        Position = (UDim2.new(0, 14, 0, 8)),
        Size = (UDim2.new(1, -28, 0, 22)),
        TextSize = (getThemeColor("ConfigTitle")),
        Font = builderSans,
        Color = Theme.Text,
      })).Parent = frame

      local scrollingFrame = (createInstance("ScrollingFrame", {
        Size = (UDim2.new(1, -28, 0, 28)),
        Position = (UDim2.new(0, 14, 0, 34)),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        CanvasSize = (UDim2.new(0, 0, 0, 28)),
        AutomaticCanvasSize = Enum.AutomaticSize.X,
        ScrollBarThickness = 0,
        ScrollingDirection = Enum.ScrollingDirection.X,
      }))

      scrollingFrame.Parent = frame

      ;(createInstance("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = (UDim.new(0, 6)),
      })).Parent = scrollingFrame

      local textBox = (createInstance("TextBox", {
        Text = "",
        PlaceholderText = "New config name...",
        Size = (UDim2.new(1, -28, 0, 0)),
        Position = (UDim2.new(0, 14, 0, 66)),
        BackgroundColor3 = Theme.Track,
        BorderSizePixel = 0,
        TextColor3 = Theme.Text,
        PlaceholderColor3 = Theme.Muted,
        TextSize = (getThemeColor("ConfigInput")),
        Font = builderSans,
        Visible = false,
      }, { addCorner(5) }))

      textBox.Parent = frame

      local function refreshConfigList()
        local ret1, ret2, ret3

        for index32, value46 in ipairs(scrollingFrame:GetChildren()) do
          if (value46:IsA("TextButton")) then
            value46:Destroy()
          end
        end

        local getConfigs = window2:GetConfigs()
        local selectedConfig = window2._selectedConfig

        for index33, value47 in ipairs(getConfigs) do

          local value = value47 == selectedConfig

          local configEntry = value47

          local udim16 = UDim2.new(0, #value47 * 9 + 20, 1, 0)

          local createInstance2 = createInstance

          local isSelectedConfig = value

          local color3 = value and Color3.new(1, 1, 1) or Theme.TrackHover

          local createInstance3 = createInstance

          local textButton = createInstance("TextButton", {
            Text = value47,
            Size = udim16,
            BackgroundColor3 = color3,
            TextColor3 = Theme.Text,
            TextSize = (getThemeColor("ConfigButton")),
            Font = builderSans,
            AutoButtonColor = false,
          }, { addCorner(5) })

          if value then
            createButton(textButton, window2.Theme.Primary, window2.Theme.Accent, nil, window2)
          end

          textButton.Parent = scrollingFrame

          textButton.MouseButton1Click:Connect(function()
            window2._selectedConfig = value47
            textBox.Text = value47
            refreshConfigList()
            return
          end)
        end

        return
      end

      window2._casConfigInput = textBox
      window2._refreshCasButtons = refreshConfigList

      refreshConfigList()
      return
    end

    return config3
  else
    if self.Window then
      config3 = self
      window2 = config3.Window
      config3._isConfigSystem = true

      function config3._renderConfigUI()
        local frame = createInstance("Frame", {
          Size = (UDim2.new(1, 0, 0, 66)),
          BackgroundColor3 = Theme.Card,
          BorderSizePixel = 0,
        }, { addCorner(7) })

        frame.Parent = window2.List

        ;(fitTextSize({
          Text = "Configs",
          Position = (UDim2.new(0, 14, 0, 8)),
          Size = (UDim2.new(1, -28, 0, 22)),
          TextSize = (getThemeColor("ConfigTitle")),
          Font = builderSans,
          Color = Theme.Text,
        })).Parent = frame

        local scrollingFrame = (createInstance("ScrollingFrame", {
          Size = (UDim2.new(1, -28, 0, 28)),
          Position = (UDim2.new(0, 14, 0, 34)),
          BackgroundTransparency = 1,
          BorderSizePixel = 0,
          CanvasSize = (UDim2.new(0, 0, 0, 28)),
          AutomaticCanvasSize = Enum.AutomaticSize.X,
          ScrollBarThickness = 0,
          ScrollingDirection = Enum.ScrollingDirection.X,
        }))

        scrollingFrame.Parent = frame

        ;(createInstance("UIListLayout", {
          FillDirection = Enum.FillDirection.Horizontal,
          SortOrder = Enum.SortOrder.LayoutOrder,
          Padding = (UDim.new(0, 6)),
        })).Parent = scrollingFrame

        local textBox = (createInstance("TextBox", {
          Text = "",
          PlaceholderText = "New config name...",
          Size = (UDim2.new(1, -28, 0, 0)),
          Position = (UDim2.new(0, 14, 0, 66)),
          BackgroundColor3 = Theme.Track,
          BorderSizePixel = 0,
          TextColor3 = Theme.Text,
          PlaceholderColor3 = Theme.Muted,
          TextSize = (getThemeColor("ConfigInput")),
          Font = builderSans,
          Visible = false,
        }, { addCorner(5) }))

        textBox.Parent = frame

        local function refreshConfigList()
          local ret1, ret2, ret3

          for index32, value46 in ipairs(scrollingFrame:GetChildren()) do
            if (value46:IsA("TextButton")) then
              value46:Destroy()
            end
          end

          local getConfigs = window2:GetConfigs()
          local selectedConfig = window2._selectedConfig

          for index33, value47 in ipairs(getConfigs) do

            local value = value47 == selectedConfig

            local configEntry = value47

            local udim16 = UDim2.new(0, #value47 * 9 + 20, 1, 0)

            local createInstance2 = createInstance

            local isSelectedConfig = value

            local color3 = value and Color3.new(1, 1, 1) or Theme.TrackHover

            local createInstance3 = createInstance

            local textButton = createInstance("TextButton", {
              Text = value47,
              Size = udim16,
              BackgroundColor3 = color3,
              TextColor3 = Theme.Text,
              TextSize = (getThemeColor("ConfigButton")),
              Font = builderSans,
              AutoButtonColor = false,
            }, { addCorner(5) })

            if value then
              createButton(textButton, window2.Theme.Primary, window2.Theme.Accent, nil, window2)
            end

            textButton.Parent = scrollingFrame

            textButton.MouseButton1Click:Connect(function()
              window2._selectedConfig = value47
              textBox.Text = value47
              refreshConfigList()
              return
            end)
          end

          return
        end

        window2._casConfigInput = textBox
        window2._refreshCasButtons = refreshConfigList

        refreshConfigList()
        return
      end

      return config3
    else
      return
    end
  end
end

function Library.GetFontSize(self, base, scale)
  return getThemeColor(base, scale)
end

function Library.DestroyAll(self)

  for index34, value48 in ipairs(self._windows) do

    pcall(function()
      local configValue6 = value48
      value48:Destroy()
      return
    end)
  end

  self._windows = {}
  return
end

function Library:Notify(title, content, duration)
  local windows = self._windows[#self._windows]

  if windows and windows.Notify then
    return windows:Notify(title, content, duration)
  else
    return nil
  end
end

return Library
end

local Library
local LOAD_ERR = nil
do
	local ok, res = pcall(__loadBundledMoon)
	if ok and type(res) == "table" and type(res.CreateWindow) == "function" then
		Library = res
	elseif not ok then
		LOAD_ERR = res
	else
		LOAD_ERR = "内置库返回异常: " .. tostring(type(res))
	end
end

-- 外部加载兜底 (内置库万一失效时用)
if not Library then
	local MOON_URL = ""
	if MOON_URL ~= "" then
		local ok, res = pcall(function()
			return loadstring(game:HttpGet(MOON_URL))()
		end)
		if ok and type(res) == "table" then
			Library = res
		end
	end
	if not Library then
		local function getEnv0()
			if type(getgenv) == "function" then
				local ok, res = pcall(getgenv)
				if ok and type(res) == "table" then
					return res
				end
			end
			return _G
		end
		local g = getEnv0()
		Library = g.MoonUI or g.MoonLibrary or g.Moon or g.Library
	end
end

if type(Library) ~= "table" or type(Library.CreateWindow) ~= "function" then
	-- [Zaka 补丁 3] 原来这里只是 warn 一句就悄悄退出 = "跑了没反应"的元凶
	print("[Zaka Hub] 内置库加载失败 | 原因: " .. tostring(LOAD_ERR))
	pcall(function()
		local plr = game:GetService("Players").LocalPlayer
		local pg = plr and plr:FindFirstChildOfClass("PlayerGui")
		if not pg then
			return
		end
		local g = Instance.new("ScreenGui")
		g.Name = "ZakaHubLoadError"
		g.ResetOnSpawn = false
		g.IgnoreGuiInset = true
		g.DisplayOrder = 2147483000
		g.Parent = pg

		local f = Instance.new("TextLabel")
		f.Size = UDim2.new(1, -36, 0, 96)
		f.Position = UDim2.new(0, 18, 0, 24)
		f.BackgroundColor3 = Color3.fromRGB(22, 24, 32)
		f.BackgroundTransparency = 0.05
		f.TextColor3 = Color3.fromRGB(255, 130, 130)
		f.TextSize = 14
		f.TextWrapped = true
		f.TextXAlignment = Enum.TextXAlignment.Left
		f.TextYAlignment = Enum.TextYAlignment.Center
		f.Text = "  Zaka Hub 加载失败: UI 库没起来\n  原因: " .. tostring(LOAD_ERR) .. "\n  把这段截图发给作者即可定位"
		f.Parent = g

		local c = Instance.new("UICorner")
		c.CornerRadius = UDim.new(0, 12)
		c.Parent = f
	end)
	return
end

--======================================================================
-- [1] 服务 & 基础环境
--======================================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local WS = game:GetService("Workspace")
local GuiService = game:GetService("GuiService")
local LP = Players.LocalPlayer

-- [Zaka 补丁 4] 手机端: 没有键盘, 默认按键按不了 → 自瞄改用"按住屏幕"
local IS_TOUCH = (UIS.TouchEnabled == true) and (UIS.KeyboardEnabled ~= true)
local TOUCH_KEY = "触摸按住(手机)"

-- [Zaka 补丁 6] getEnv 之前漏了定义, 卸载段直接崩在这
local function getEnv()
	if type(getgenv) == "function" then
		local ok, env = pcall(getgenv)
		if ok and type(env) == "table" then
			return env
		end
	end
	return _G
end

local HOOKFUNC = nil
if type(hookfunction) == "function" then
	HOOKFUNC = hookfunction
end

local DRAWING = nil
do
	local ok, res = pcall(function()
		return Drawing
	end)
	if ok and type(res) == "table" then
		DRAWING = res
	end
end

local EXCLUDE_TYPE = nil
do
	local ok, v = pcall(function()
		return Enum.RaycastFilterType.Exclude
	end)
	if ok and v then
		EXCLUDE_TYPE = v
	else
		local ok2, v2 = pcall(function()
			return Enum.RaycastFilterType.Blacklist
		end)
		if ok2 then
			EXCLUDE_TYPE = v2
		end
	end
end

--======================================================================
-- [2] 全局状态
--======================================================================
local S = {
	Aim = {
		Enabled = false,
		Always = false,
		Key = IS_TOUCH and TOUCH_KEY or "E",
		Holding = false,
		Part = "Head",
		FOV = 120,
		ShowFOV = true,
		Smooth = 0.35,
		Predict = 30,
		WallCheck = true,
		TeamCheck = true,
	},
	Silent = {
		Enabled = false,
		Part = "Head",
		FOV = 150,
		Predict = 25,
		WallCheck = false,
		TeamCheck = true,
	},
	ESP = {
		Enabled = false,
		Box = true,
		Name = true,
		Distance = true,
		Health = true,
		Highlight = false,
		MaxDist = 1000,
		TeamCheck = true,
		Color = Color3.fromRGB(120, 200, 255),
	},
	Fly = {
		Enabled = false,
		Speed = 60,
		Mode = "相机朝向",
	},
	Move = {
		SpeedEnabled = false,
		WalkSpeed = 32,
		JumpEnabled = false,
		JumpPower = 60,
		InfJump = false,
		Noclip = false,
		AntiAFK = false,
	},
	UI = {
		Ball = true,
		BallSize = 46,
		BallAlpha = 0.15,
		Quick = "自瞄",
	},
}

--======================================================================
-- [3] 通用工具函数
--======================================================================
local function getCamera()
	return WS.CurrentCamera
end

local function getChar(plr)
	local p = plr or LP
	return p and p.Character or nil
end

local function getHum(plr)
	local c = getChar(plr)
	if not c then
		return nil
	end
	return c:FindFirstChildOfClass("Humanoid")
end

local function getHRP(plr)
	local c = getChar(plr)
	if not c then
		return nil
	end
	return c:FindFirstChild("HumanoidRootPart")
end

local function isAlive(plr)
	local c = getChar(plr)
	if not c then
		return false
	end
	local h = c:FindFirstChildOfClass("Humanoid")
	if not h or h.Health <= 0 then
		return false
	end
	return c:FindFirstChild("HumanoidRootPart") ~= nil
end

local function isTeammate(plr)
	if plr == LP then
		return true
	end
	if LP.Team ~= nil and plr.Team ~= nil then
		return plr.Team == LP.Team
	end
	return false
end

local function getAimPart(plr, partName)
	local c = getChar(plr)
	if not c then
		return nil
	end
	local p = c:FindFirstChild(partName)
	if not p then
		p = c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Head")
	end
	if p and p:IsA("BasePart") then
		return p
	end
	return nil
end

local function getVelocity(part)
	local ok, v = pcall(function()
		return part.AssemblyLinearVelocity
	end)
	if ok and typeof(v) == "Vector3" then
		return v
	end
	return part.Velocity or Vector3.zero
end

local function getPing()
	local ok, p = pcall(function()
		return LP:GetNetworkPing()
	end)
	if ok and type(p) == "number" and p > 0 then
		return p
	end
	return 0.06
end

-- 提前量预测 (predict 0~100)
local function getAimPosition(part, predict)
	local pos = part.Position
	if not predict or predict <= 0 then
		return pos
	end
	local lead = getPing() + (predict / 100) * 0.35
	return pos + getVelocity(part) * lead
end

local function canSee(part)
	local cam = getCamera()
	if not cam or not part or not EXCLUDE_TYPE then
		return true
	end
	local origin = cam.CFrame.Position
	local params = RaycastParams.new()
	params.FilterType = EXCLUDE_TYPE
	params.FilterDescendantsInstances = { LP.Character, cam }
	local ok, hit = pcall(function()
		return WS:Raycast(origin, part.Position - origin, params)
	end)
	if not ok or not hit then
		return true
	end
	local inst = hit.Instance
	if not inst then
		return true
	end
	return inst == part or inst:IsDescendantOf(part.Parent)
end

local NULL_INSET = Vector2.new(0, 0)
local function getInset()
	local ok, v = pcall(function()
		return GuiService:GetGuiInset()
	end)
	if ok and v then
		return v
	end
	return NULL_INSET
end

--======================================================================
-- [4] ESP 模块
--======================================================================
local espCache = {}
local espConn = nil

local function safeRemove(obj)
	if obj and obj.Remove then
		pcall(function()
			obj:Remove()
		end)
	end
end

local function newESPObjects()
	local d = { lines = {}, texts = {}, bars = {} }
	if DRAWING then
		local ok = pcall(function()
			for i = 1, 4 do
				local l = DRAWING.new("Line")
				l.Thickness = 1
				l.Transparency = 1
				l.Visible = false
				d.lines[i] = l
			end
			for i = 1, 2 do
				local l = DRAWING.new("Line")
				l.Thickness = 4
				l.Transparency = 1
				l.Visible = false
				d.bars[i] = l
			end
			local t1 = DRAWING.new("Text")
			t1.Size = 13
			t1.Center = true
			t1.Outline = true
			t1.Visible = false
			t1.Transparency = 1
			if t1.Font ~= nil and DRAWING.Fonts then
				pcall(function()
					t1.Font = DRAWING.Fonts.UI
				end)
			end
			d.texts[1] = t1

			local t2 = DRAWING.new("Text")
			t2.Size = 12
			t2.Center = true
			t2.Outline = true
			t2.Visible = false
			t2.Transparency = 1
			d.texts[2] = t2
		end)
		if not ok then
			-- 部分执行器的 Drawing 不完整, 直接退回 Highlight 方案
			DRAWING = nil
		end
	end
	return d
end

local function destroyESPData(d)
	if not d then
		return
	end
	for _, l in ipairs(d.lines or {}) do
		safeRemove(l)
	end
	for _, l in ipairs(d.bars or {}) do
		safeRemove(l)
	end
	for _, t in ipairs(d.texts or {}) do
		safeRemove(t)
	end
	if d.highlight then
		pcall(function()
			d.highlight:Destroy()
		end)
	end
	if d.billboard then
		pcall(function()
			d.billboard:Destroy()
		end)
	end
end

local function setLine(l, a, b)
	l.From = a
	l.To = b
	l.Visible = true
	l.Transparency = 0
end

local function hideESPData(d)
	for _, l in ipairs(d.lines or {}) do
		l.Visible = false
	end
	for _, l in ipairs(d.bars or {}) do
		l.Visible = false
	end
	for _, t in ipairs(d.texts or {}) do
		t.Visible = false
	end
	if d.highlight then
		d.highlight.Enabled = false
	end
	if d.billboard then
		d.billboard.Enabled = false
	end
end

local function ensureHighlight(d, plr)
	if not S.ESP.Highlight then
		if d.highlight then
			d.highlight.Enabled = false
		end
		return
	end

	local char = getChar(plr)
	if not char then
		return
	end

	if not d.highlight or not d.highlight.Parent then
		local hl = Instance.new("Highlight")
		hl.Name = "ZakaESPHighlight"
		hl.FillColor = S.ESP.Color
		hl.OutlineColor = S.ESP.Color
		hl.FillTransparency = 0.7
		hl.OutlineTransparency = 0
		pcall(function()
			hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		end)
		hl.Adornee = char
		hl.Parent = char
		d.highlight = hl
	end

	d.highlight.Adornee = char
	d.highlight.Enabled = true
	d.highlight.FillColor = S.ESP.Color
	d.highlight.OutlineColor = S.ESP.Color
end

-- 无 Drawing 时的兜底: 名字标签
local function ensureBillboard(d, plr, dist)
	local char = getChar(plr)
	if not char then
		return
	end
	local head = char:FindFirstChild("Head")
	if not head then
		return
	end

	if not d.billboard or not d.billboard.Parent then
		local bb = Instance.new("BillboardGui")
		bb.Name = "ZakaESPInfo"
		bb.Size = UDim2.new(0, 140, 0, 34)
		bb.StudsOffset = Vector3.new(0, 2.4, 0)
		bb.AlwaysOnTop = true
		bb.Adornee = head
		local lbl = Instance.new("TextLabel")
		lbl.Name = "Info"
		lbl.BackgroundTransparency = 1
		lbl.Size = UDim2.new(1, 0, 1, 0)
		lbl.Font = Enum.Font.GothamBold
		lbl.TextScaled = true
		lbl.TextColor3 = S.ESP.Color
		lbl.TextStrokeTransparency = 0.2
		lbl.Text = plr.Name
		lbl.Parent = bb
		bb.Parent = head
		d.billboard = bb
		d.label = lbl
	end

	d.billboard.Adornee = head
	d.billboard.Enabled = true
	local txt = plr.Name
	if S.ESP.Health then
		local h = getHum(plr)
		if h then
			txt = txt .. "  " .. math.floor(h.Health) .. "HP"
		end
	end
	if S.ESP.Distance then
		txt = txt .. "  " .. math.floor(dist) .. "m"
	end
	d.label.Text = txt
	d.label.TextColor3 = S.ESP.Color
end

local function updateESP()
	local cam = getCamera()
	if not cam then
		return
	end
	local inset = getInset()
	local camPos = cam.CFrame.Position

	for _, plr in ipairs(Players:GetPlayers()) do
		local d = espCache[plr]
		if not d then
			d = newESPObjects()
			espCache[plr] = d
		end

		local show = S.ESP.Enabled and plr ~= LP and isAlive(plr)
		if show and S.ESP.TeamCheck and isTeammate(plr) then
			show = false
		end

		local hrp = show and getHRP(plr) or nil
		local dist = 0
		if hrp then
			dist = (camPos - hrp.Position).Magnitude
			if dist > S.ESP.MaxDist then
				show = false
			end
		end

		if not show then
			hideESPData(d)
		else
			ensureHighlight(d, plr)

			local hpRatio = 1
			local hum = getHum(plr)
			if hum and hum.MaxHealth > 0 then
				hpRatio = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
			end

			if not DRAWING then
				ensureBillboard(d, plr, dist)
			else
				local topW = hrp.Position + Vector3.new(0, 2.6, 0)
				local botW = hrp.Position - Vector3.new(0, 3.2, 0)
				local pTop = cam:WorldToViewportPoint(topW)
				local pBot = cam:WorldToViewportPoint(botW)
				local pMid = cam:WorldToViewportPoint(hrp.Position)

				if pMid.Z > 0 then
					local x1 = pMid.X
					local y1 = pTop.Y + inset.Y
					local y2 = pBot.Y + inset.Y
					local height = math.abs(y2 - y1)
					local width = height * 0.55
					local left = x1 - width / 2
					local right = x1 + width / 2

					if height > 8 then
						if S.ESP.Box then
							setLine(d.lines[1], Vector2.new(left, y1), Vector2.new(right, y1))
							setLine(d.lines[2], Vector2.new(right, y1), Vector2.new(right, y2))
							setLine(d.lines[3], Vector2.new(right, y2), Vector2.new(left, y2))
							setLine(d.lines[4], Vector2.new(left, y2), Vector2.new(left, y1))
							for i = 1, 4 do
								d.lines[i].Color = S.ESP.Color
							end
						else
							for i = 1, 4 do
								d.lines[i].Visible = false
							end
						end

						local head = d.texts[1]
						local txt = ""
						if S.ESP.Name then
							txt = plr.Name
						end
						if S.ESP.Distance then
							if txt ~= "" then
								txt = txt .. " "
							end
							txt = txt .. "[" .. math.floor(dist) .. "m]"
						end
						if txt ~= "" then
							head.Text = txt
							head.Position = Vector2.new(x1, y1 - 15)
							head.Color = S.ESP.Color
							head.Visible = true
							head.Transparency = 0
						else
							head.Visible = false
						end

						if S.ESP.Health then
							local barY = y2 + 4
							local bg = d.bars[1]
							local fill = d.bars[2]
							setLine(bg, Vector2.new(left, barY), Vector2.new(right, barY))
							setLine(fill, Vector2.new(left, barY), Vector2.new(left + width * hpRatio, barY))
							bg.Color = Color3.fromRGB(0, 0, 0)
							bg.Transparency = 0.35
							if hpRatio > 0.6 then
								fill.Color = Color3.fromRGB(80, 230, 120)
							elseif hpRatio > 0.3 then
								fill.Color = Color3.fromRGB(240, 200, 70)
							else
								fill.Color = Color3.fromRGB(235, 80, 80)
							end

							local hpText = d.texts[2]
							hpText.Text = math.floor(hpRatio * 100) .. "%"
							hpText.Position = Vector2.new(x1, barY + 2)
							hpText.Color = fill.Color
							hpText.Visible = true
							hpText.Transparency = 0
						else
							d.bars[1].Visible = false
							d.bars[2].Visible = false
							d.texts[2].Visible = false
						end
					else
						for i = 1, 4 do
							d.lines[i].Visible = false
						end
						d.bars[1].Visible = false
						d.bars[2].Visible = false
						d.texts[1].Visible = false
						d.texts[2].Visible = false
					end
				else
					hideESPData(d)
				end
			end
		end
	end

	-- 清理离场玩家
	for plr, d in pairs(espCache) do
		if not plr.Parent then
			destroyESPData(d)
			espCache[plr] = nil
		end
	end
end

local function clearESP()
	for plr, d in pairs(espCache) do
		destroyESPData(d)
		espCache[plr] = nil
	end
end

--======================================================================
-- [5] 自瞄 / 目标查找
--======================================================================
local fovCircle = nil
if DRAWING then
	local ok, circle = pcall(function()
		local c = DRAWING.new("Circle")
		c.Thickness = 1
		c.NumSides = 60
		c.Filled = false
		c.Transparency = 0.7
		c.Color = Color3.new(1, 1, 1)
		c.Visible = false
		return c
	end)
	if ok then
		fovCircle = circle
	end
end

-- 瞄准基准点: PC 用鼠标位置, 纯触屏(手机)用屏幕中心
local function getAimCenter(forceCenter)
	local cam = getCamera()
	if forceCenter or (UIS.TouchEnabled and not UIS.KeyboardEnabled) then
		if cam then
			local v = cam.ViewportSize
			return Vector2.new(v.X / 2, v.Y / 2 + getInset().Y)
		end
	end
	return UIS:GetMouseLocation()
end

-- o = {FOV, Part, TeamCheck, Predict, WallCheck}
local function findTarget(o, useCenter)
	local cam = getCamera()
	if not cam then
		return nil
	end

	local center = getAimCenter(useCenter)

	local inset = getInset()
	local best, bestScore = nil, o.FOV

	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LP and isAlive(plr) then
			local skip = false
			if o.TeamCheck and isTeammate(plr) then
				skip = true
			end

			if not skip then
				local part = getAimPart(plr, o.Part)
				if part then
					local pos = getAimPosition(part, o.Predict)
					local sp = cam:WorldToViewportPoint(pos)
					if sp.Z > 0 then
						local screenPos = Vector2.new(sp.X, sp.Y + inset.Y)
						local score = (screenPos - center).Magnitude
						if score <= bestScore then
							bestScore = score
							best = {
								Player = plr,
								Part = part,
								Position = pos,
								Screen = screenPos,
								Score = score,
							}
						end
					end
				end
			end
		end
	end

	if best and o.WallCheck then
		if not canSee(best.Part) then
			return nil
		end
	end

	return best
end

local function applyAim(target)
	local cam = getCamera()
	if not cam or not target then
		return
	end
	local goal = CFrame.new(cam.CFrame.Position, target.Position)
	local smooth = math.clamp(S.Aim.Smooth, 0.03, 1)
	if smooth >= 0.99 then
		cam.CFrame = goal
	else
		cam.CFrame = cam.CFrame:Lerp(goal, smooth)
	end
end

--======================================================================
-- [6] 子弹追踪 (Silent Aim)
--======================================================================
local hooked = {}
local silentHookOK = false
local silentCacheTime = 0
local silentCacheTarget = nil

-- 射线每秒会被游戏调用很多次, 目标结果做 0.05s 缓存, 避免掉帧
local function getSilentTarget()
	local now = os.clock()
	if now - silentCacheTime < 0.05 then
		return silentCacheTarget
	end
	silentCacheTime = now
	silentCacheTarget = findTarget(S.Silent, true)
	return silentCacheTarget
end

local function installSilentHook()
	if silentHookOK then
		return true
	end
	if not HOOKFUNC then
		return false
	end

	local ok1 = pcall(function()
		hooked.Raycast = HOOKFUNC(WS.Raycast, function(self, origin, direction, params)
			if S.Silent.Enabled and direction then
				local t = getSilentTarget()
				if t then
					local nd = t.Position - origin
					if nd.Magnitude > 0.05 then
						direction = nd
					end
				end
			end
			return hooked.Raycast(self, origin, direction, params)
		end)
	end)
	if ok1 then
		silentHookOK = true
	end

	pcall(function()
		hooked.RayIgnore = HOOKFUNC(WS.FindPartOnRayWithIgnoreList, function(self, ray, ignoreList, a, b)
			if S.Silent.Enabled and ray then
				local t = getSilentTarget()
				if t then
					local nd = t.Position - ray.Origin
					if nd.Magnitude > 0.05 then
						ray = Ray.new(ray.Origin, nd)
					end
				end
			end
			return hooked.RayIgnore(self, ray, ignoreList, a, b)
		end)
		silentHookOK = true
	end)

	pcall(function()
		hooked.RayPlain = HOOKFUNC(WS.FindPartOnRay, function(self, ray, ignore)
			if S.Silent.Enabled and ray then
				local t = getSilentTarget()
				if t then
					local nd = t.Position - ray.Origin
					if nd.Magnitude > 0.05 then
						ray = Ray.new(ray.Origin, nd)
					end
				end
			end
			return hooked.RayPlain(self, ray, ignore)
		end)
		silentHookOK = true
	end)

	return silentHookOK
end

local function removeSilentHook()
	if not HOOKFUNC then
		return
	end
	if hooked.Raycast then
		pcall(function()
			HOOKFUNC(WS.Raycast, hooked.Raycast)
		end)
	end
	if hooked.RayIgnore then
		pcall(function()
			HOOKFUNC(WS.FindPartOnRayWithIgnoreList, hooked.RayIgnore)
		end)
	end
	if hooked.RayPlain then
		pcall(function()
			HOOKFUNC(WS.FindPartOnRay, hooked.RayPlain)
		end)
	end
	silentHookOK = false
end

--======================================================================
-- [7] 飞行 & 移动增强
--======================================================================
local flyBV, flyBG
local noclipSaved = {}

local function stopFly()
	if flyBV then
		pcall(function()
			flyBV:Destroy()
		end)
		flyBV = nil
	end
	if flyBG then
		pcall(function()
			flyBG:Destroy()
		end)
		flyBG = nil
	end
	local hum = getHum()
	if hum then
		pcall(function()
			hum.PlatformStand = false
		end)
	end
end

local function updateFly()
	local char = getChar()
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if not hrp or not hum then
		stopFly()
		return
	end

	if not flyBV or not flyBV.Parent then
		flyBV = Instance.new("BodyVelocity")
		flyBV.Name = "ZakaFlyVelocity"
		flyBV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
		flyBV.P = 12500
		flyBV.Velocity = Vector3.zero
		flyBV.Parent = hrp
	end
	if not flyBG or not flyBG.Parent then
		flyBG = Instance.new("BodyGyro")
		flyBG.Name = "ZakaFlyGyro"
		flyBG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
		flyBG.P = 8000
		flyBG.D = 120
		flyBG.CFrame = hrp.CFrame
		flyBG.Parent = hrp
	end

	-- 移动输入: 键盘 WASD + 手机摇杆 MoveDirection 双兼容
	-- (不用 PlatformStand, 否则手机摇杆会被禁掉)
	local cam = getCamera()
	local moveX, moveZ, fromKeys = 0, 0, false
	if UIS:IsKeyDown(Enum.KeyCode.W) then
		moveZ = moveZ - 1
		fromKeys = true
	end
	if UIS:IsKeyDown(Enum.KeyCode.S) then
		moveZ = moveZ + 1
		fromKeys = true
	end
	if UIS:IsKeyDown(Enum.KeyCode.A) then
		moveX = moveX - 1
		fromKeys = true
	end
	if UIS:IsKeyDown(Enum.KeyCode.D) then
		moveX = moveX + 1
		fromKeys = true
	end

	local dir
	if fromKeys then
		if S.Fly.Mode == "相机朝向" and cam then
			local rel = cam.CFrame:VectorToWorldSpace(Vector3.new(moveX, 0, moveZ))
			dir = Vector3.new(rel.X, 0, rel.Z)
		else
			dir = Vector3.new(moveX, 0, moveZ)
		end
	else
		local md = hum.MoveDirection
		dir = Vector3.new(md.X, 0, md.Z)
	end
	if dir.Magnitude < 0.05 then
		dir = Vector3.zero
	end

	local up = 0
	if UIS:IsKeyDown(Enum.KeyCode.Space) then
		up = up + 1
	end
	if UIS:IsKeyDown(Enum.KeyCode.LeftShift) or UIS:IsKeyDown(Enum.KeyCode.RightShift) then
		up = up - 1
	end

	local speed = S.Fly.Speed
	local vel = Vector3.zero
	if dir.Magnitude > 0.05 then
		vel = dir.Unit * speed
	end
	vel = vel + Vector3.new(0, up * speed, 0)

	flyBV.Velocity = vel
	if cam then
		flyBG.CFrame = CFrame.new(hrp.Position, hrp.Position + cam.CFrame.LookVector)
	end
end

local function applyMovement()
	local hum = getHum()
	if not hum then
		return
	end
	if S.Move.SpeedEnabled then
		pcall(function()
			hum.WalkSpeed = S.Move.WalkSpeed
		end)
	end
	if S.Move.JumpEnabled then
		pcall(function()
			hum.JumpPower = S.Move.JumpPower
			hum.UseJumpPower = true
		end)
	end
end

local function updateNoclip()
	if not S.Move.Noclip then
		return
	end
	local char = getChar()
	if not char then
		return
	end
	for _, d in ipairs(char:GetDescendants()) do
		if d:IsA("BasePart") and d.CanCollide then
			if noclipSaved[d] == nil then
				noclipSaved[d] = true
			end
			d.CanCollide = false
		end
	end
end

local function restoreNoclip()
	for part in pairs(noclipSaved) do
		pcall(function()
			part.CanCollide = true
		end)
		noclipSaved[part] = nil
	end
end

local function teleportTo(plr)
	local myHrp = getHRP()
	local target = plr and getHRP(plr)
	if not myHrp or not target then
		return false
	end
	pcall(function()
		myHrp.CFrame = target.CFrame * CFrame.new(0, 3, 0)
	end)
	return true
end

--======================================================================
-- [8] 悬浮球
--======================================================================
local ballGui, ballBtn
local lastTap = 0
local quickActions = nil

local function makeGuiContainer(name)
	local parent
	local ok, hui = pcall(function()
		return gethui()
	end)
	if ok and hui then
		parent = hui
	else
		parent = LP:WaitForChild("PlayerGui")
	end
	local g = Instance.new("ScreenGui")
	g.Name = name
	g.ResetOnSpawn = false
	g.IgnoreGuiInset = true
	g.DisplayOrder = 2147483000
	g.Parent = parent
	return g
end

local function refreshBall()
	if not ballBtn then
		return
	end
	ballBtn.Size = UDim2.fromOffset(S.UI.BallSize, S.UI.BallSize)
	ballBtn.BackgroundTransparency = S.UI.BallAlpha
	ballBtn.Visible = S.UI.Ball
end

local function createBall(onToggleUI)
	if ballGui then
		return
	end
	ballGui = makeGuiContainer("ZakaFloatingBall")

	local btn = Instance.new("TextButton")
	btn.Name = "Ball"
	btn.Size = UDim2.fromOffset(S.UI.BallSize, S.UI.BallSize)
	btn.Position = UDim2.new(0, 24, 0.45, 0)
	btn.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
	btn.BackgroundTransparency = S.UI.BallAlpha
	btn.BorderSizePixel = 0
	btn.Text = "Z"
	btn.TextColor3 = Color3.fromRGB(120, 200, 255)
	local okFont = pcall(function()
		btn.Font = Enum.Font.GothamBold
	end)
	if not okFont then
		btn.Font = Enum.Font.SourceSansBold
	end
	btn.TextSize = 20
	btn.AutoButtonColor = false
	btn.Active = true
	btn.Draggable = false
	btn.Parent = ballGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(1, 0)
	corner.Parent = btn

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(120, 200, 255)
	stroke.Thickness = 1.5
	stroke.Transparency = 0.25
	stroke.Parent = btn

	ballBtn = btn
	refreshBall()

	local dragging = false
	local moved = false
	local dragStart = nil
	local startPos = nil

	btn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			moved = false
			dragStart = input.Position
			startPos = btn.Position
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if not dragging then
			return
		end
		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then
			local delta = input.Position - dragStart
			if delta.Magnitude > 8 then
				moved = true
			end
			btn.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)

	UIS.InputEnded:Connect(function(input)
		if not dragging then
			return
		end
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
			if moved then
				return
			end
			local now = os.clock()
			if now - lastTap < 0.35 then
				lastTap = 0
				if quickActions then
					quickActions()
				end
			else
				lastTap = now
				task.delay(0.36, function()
					if lastTap ~= 0 and os.clock() - lastTap >= 0.34 then
						lastTap = 0
						onToggleUI()
					end
				end)
			end
		end
	end)
end

local function destroyBall()
	if ballGui then
		pcall(function()
			ballGui:Destroy()
		end)
		ballGui = nil
		ballBtn = nil
	end
end

--======================================================================
-- [9] 界面
--======================================================================
if type(Library.Themes) == "table" then
	-- 库已导出主题表
end

local Window = Library:CreateWindow({
	Title = "Zaka Hub",
	Version = "v1.0",
	Theme = "Aqua",
	Size = UDim2.new(0, 640, 0, 540),
	ToggleKey = Enum.KeyCode.RightShift,
	ConfigFolder = "ZakaHub/Configs",
	GradientAnimation = true,
})

-- [Zaka 补丁 5] 这套库的控件挂在"模块"上, 不是挂在 Tab 上:
--   Window → Tab:CreateModule() → Module:CreateToggle/CreateSlider/...
-- 上一版直接 Tab:CreateToggle 是 nil, 建完窗口就崩在这儿 (= 界面一片空)
local function newTab(name)
	local tab = Window:CreateTab({ Name = name })
	local api = { _tab = tab, _cur = nil }
	function api:Module(mName, mDesc)
		local ok, mod = pcall(function()
			return tab:CreateModule({ Name = mName, Description = mDesc or "", Default = true })
		end)
		if ok and mod then
			self._cur = mod
			pcall(function()
				mod:SetExpanded(true)
			end)
		end
		return self
	end
	for _, mName in ipairs({
		"CreateToggle",
		"CreateSlider",
		"CreateSelector",
		"CreateButton",
		"CreateInput",
		"CreateKeybind",
		"CreateColorPicker",
	}) do
		api[mName] = function(self, opts)
			if not self._cur then
				self:Module("功能")
			end
			local mod = self._cur
			local fn = mod and mod[mName]
			if type(fn) ~= "function" then
				return nil
			end
			return fn(mod, opts)
		end
	end
	return api
end

local TCombat = newTab("战斗")
local TVisual = newTab("视觉")
local TMove = newTab("移动")
local TMisc = newTab("杂项")

local silentToggle, aimToggle, espToggle, flyToggle

-- ---------------- 战斗 ----------------
TCombat:Module("自瞄 Aimbot", "锁定部位 / 平滑度 / 提前量 / 隔墙检查")

aimToggle = TCombat:CreateToggle({
	Name = "自瞄 Aimbot",
	Default = false,
	Callback = function(v)
		S.Aim.Enabled = v
	end,
})

TCombat:CreateToggle({
	Name = "始终锁定 (不需要按键)",
	Default = false,
	Callback = function(v)
		S.Aim.Always = v
	end,
})

TCombat:CreateSelector({
	Name = "自瞄按键 (按住)",
	Options = { TOUCH_KEY, "E", "Q", "F", "R", "T", "G", "C", "X", "V", "Z", "LeftAlt" },
	Default = S.Aim.Key,
	Callback = function(v)
		S.Aim.Key = v
	end,
})

TCombat:CreateSelector({
	Name = "锁定部位",
	Options = { "Head", "UpperTorso", "LowerTorso", "HumanoidRootPart" },
	Default = "Head",
	Callback = function(v)
		S.Aim.Part = v
	end,
})

TCombat:CreateSlider({
	Name = "自瞄范围 FOV",
	Min = 20,
	Max = 600,
	Default = 120,
	Step = 10,
	Callback = function(v)
		S.Aim.FOV = v
	end,
})

TCombat:CreateSlider({
	Name = "平滑度 (越小越锁死)",
	Min = 0.05,
	Max = 1,
	Default = 0.35,
	Step = 0.05,
	Callback = function(v)
		S.Aim.Smooth = v
	end,
})

TCombat:CreateSlider({
	Name = "提前量 (打移动目标)",
	Min = 0,
	Max = 100,
	Default = 30,
	Step = 5,
	Callback = function(v)
		S.Aim.Predict = v
	end,
})

TCombat:CreateToggle({
	Name = "隔墙检查 (只锁看得见的)",
	Default = true,
	Callback = function(v)
		S.Aim.WallCheck = v
	end,
})

TCombat:CreateToggle({
	Name = "忽略队友",
	Default = true,
	Callback = function(v)
		S.Aim.TeamCheck = v
		S.Silent.TeamCheck = v
	end,
})

TCombat:CreateToggle({
	Name = "显示 FOV 圈",
	Default = true,
	Callback = function(v)
		S.Aim.ShowFOV = v
	end,
})

TCombat:Module("子弹追踪", "静默瞄准 · 改射线方向 · 不动相机")

silentToggle = TCombat:CreateToggle({
	Name = "子弹追踪 Silent Aim",
	Default = false,
	Callback = function(v)
		if v then
			local ok = installSilentHook()
			if not ok then
				S.Silent.Enabled = false
				task.defer(function()
					silentToggle:Set(false, true)
				end)
				Window:Notify({
					Title = "子弹追踪",
					Content = "当前执行器不支持,已跳过",
					Duration = 3,
				})
				return
			end
		end
		S.Silent.Enabled = v
	end,
})

TCombat:CreateSelector({
	Name = "追踪部位",
	Options = { "Head", "UpperTorso", "LowerTorso", "HumanoidRootPart" },
	Default = "Head",
	Callback = function(v)
		S.Silent.Part = v
	end,
})

TCombat:CreateSlider({
	Name = "追踪范围 FOV",
	Min = 20,
	Max = 800,
	Default = 150,
	Step = 10,
	Callback = function(v)
		S.Silent.FOV = v
	end,
})

TCombat:CreateSlider({
	Name = "追踪提前量",
	Min = 0,
	Max = 100,
	Default = 25,
	Step = 5,
	Callback = function(v)
		S.Silent.Predict = v
	end,
})

TCombat:CreateToggle({
	Name = "追踪隔墙检查",
	Default = false,
	Callback = function(v)
		S.Silent.WallCheck = v
	end,
})

-- ---------------- 视觉 ----------------
TVisual:Module("ESP 透视", "方框 / 名字 / 距离 / 血量 / 高亮")

espToggle = TVisual:CreateToggle({
	Name = "ESP 透视",
	Default = false,
	Callback = function(v)
		S.ESP.Enabled = v
		if not v then
			for _, d in pairs(espCache) do
				hideESPData(d)
			end
		end
	end,
})

TVisual:CreateToggle({
	Name = "方框",
	Default = true,
	Callback = function(v)
		S.ESP.Box = v
	end,
})

TVisual:CreateToggle({
	Name = "名字",
	Default = true,
	Callback = function(v)
		S.ESP.Name = v
	end,
})

TVisual:CreateToggle({
	Name = "距离",
	Default = true,
	Callback = function(v)
		S.ESP.Distance = v
	end,
})

TVisual:CreateToggle({
	Name = "血量",
	Default = true,
	Callback = function(v)
		S.ESP.Health = v
	end,
})

TVisual:CreateToggle({
	Name = "高亮发光 (Highlight)",
	Default = false,
	Callback = function(v)
		S.ESP.Highlight = v
	end,
})

TVisual:CreateToggle({
	Name = "忽略队友",
	Default = true,
	Callback = function(v)
		S.ESP.TeamCheck = v
	end,
})

TVisual:CreateSlider({
	Name = "最远显示距离",
	Min = 50,
	Max = 5000,
	Default = 1000,
	Step = 50,
	Callback = function(v)
		S.ESP.MaxDist = v
	end,
})

TVisual:CreateColorPicker({
	Name = "ESP 颜色",
	Default = Color3.fromRGB(120, 200, 255),
	Callback = function(c)
		S.ESP.Color = c
		for _, d in pairs(espCache) do
			if d.highlight then
				d.highlight.FillColor = c
				d.highlight.OutlineColor = c
			end
		end
	end,
})

-- ---------------- 移动 ----------------
TMove:Module("飞行", "相机朝向 / 世界方向 · 手机摇杆可飞")

flyToggle = TMove:CreateToggle({
	Name = "飞行 Fly",
	Default = false,
	Callback = function(v)
		S.Fly.Enabled = v
		if not v then
			stopFly()
		end
	end,
})

TMove:CreateSlider({
	Name = "飞行速度",
	Min = 10,
	Max = 400,
	Default = 60,
	Step = 5,
	Callback = function(v)
		S.Fly.Speed = v
	end,
})

TMove:CreateSelector({
	Name = "飞行模式",
	Options = { "相机朝向", "世界方向" },
	Default = "相机朝向",
	Callback = function(v)
		S.Fly.Mode = v
	end,
})

TMove:Module("移动增强", "速度 / 跳跃 / 穿墙 / 防挂机")

TMove:CreateToggle({
	Name = "移动加速",
	Default = false,
	Callback = function(v)
		S.Move.SpeedEnabled = v
		local hum = getHum()
		if hum and not v then
			pcall(function()
				hum.WalkSpeed = 16
			end)
		end
		applyMovement()
	end,
})

TMove:CreateSlider({
	Name = "移动速度",
	Min = 16,
	Max = 300,
	Default = 32,
	Step = 2,
	Callback = function(v)
		S.Move.WalkSpeed = v
		applyMovement()
	end,
})

TMove:CreateToggle({
	Name = "跳跃增强",
	Default = false,
	Callback = function(v)
		S.Move.JumpEnabled = v
		applyMovement()
	end,
})

TMove:CreateSlider({
	Name = "跳跃力",
	Min = 50,
	Max = 300,
	Default = 60,
	Step = 5,
	Callback = function(v)
		S.Move.JumpPower = v
		applyMovement()
	end,
})

TMove:CreateToggle({
	Name = "无限跳跃",
	Default = false,
	Callback = function(v)
		S.Move.InfJump = v
	end,
})

TMove:CreateToggle({
	Name = "穿墙 (Noclip)",
	Default = false,
	Callback = function(v)
		S.Move.Noclip = v
		if not v then
			restoreNoclip()
		end
	end,
})

TMove:CreateToggle({
	Name = "防挂机 Anti-AFK",
	Default = false,
	Callback = function(v)
		S.Move.AntiAFK = v
	end,
})

-- ---------------- 杂项 ----------------
TMisc:Module("悬浮球", "拖动 / 单击开菜单 / 双击快捷开关")

TMisc:CreateToggle({
	Name = "显示悬浮球",
	Default = true,
	Callback = function(v)
		S.UI.Ball = v
		refreshBall()
	end,
})

TMisc:CreateSlider({
	Name = "悬浮球大小",
	Min = 30,
	Max = 90,
	Default = 46,
	Step = 2,
	Callback = function(v)
		S.UI.BallSize = v
		refreshBall()
	end,
})

TMisc:CreateSlider({
	Name = "悬浮球透明度",
	Min = 0,
	Max = 0.8,
	Default = 0.15,
	Step = 0.05,
	Callback = function(v)
		S.UI.BallAlpha = v
		refreshBall()
	end,
})

TMisc:CreateSelector({
	Name = "双击悬浮球触发",
	Options = { "自瞄", "ESP", "飞行", "子弹追踪" },
	Default = "自瞄",
	Callback = function(v)
		S.UI.Quick = v
	end,
})

TMisc:Module("传送", "按名字传 / 传到最近玩家")

TMisc:CreateInput({
	Name = "传送到玩家 (填名字)",
	Default = "",
	Placeholder = "玩家名",
	Callback = function(text)
		local target = Players:FindFirstChild(text)
		if target then
			if teleportTo(target) then
				Window:Notify({ Title = "传送", Content = "已传送到 " .. target.Name, Duration = 2 })
			else
				Window:Notify({ Title = "传送", Content = "目标不在场", Duration = 2 })
			end
		else
			Window:Notify({ Title = "传送", Content = "没找到这个玩家", Duration = 2 })
		end
	end,
})

TMisc:CreateButton({
	Name = "传送到最近玩家",
	Callback = function()
		local myHrp = getHRP()
		if not myHrp then
			return
		end
		local best, bestDist = nil, math.huge
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= LP and isAlive(plr) then
				local hrp = getHRP(plr)
				if hrp then
					local d = (hrp.Position - myHrp.Position).Magnitude
					if d < bestDist and not isTeammate(plr) then
						best, bestDist = plr, d
					end
				end
			end
		end
		if best and teleportTo(best) then
			Window:Notify({ Title = "传送", Content = "已传送到 " .. best.Name, Duration = 2 })
		end
	end,
})

-- 主题选择
local themeList = {}
do
	local src = Library.Themes
	if type(src) ~= "table" then
		src = nil
		local ok, res = pcall(function()
			return Themes
		end)
		if ok and type(res) == "table" then
			src = res
		end
	end
	if type(src) == "table" then
		for k in pairs(src) do
			if type(k) == "string" then
				table.insert(themeList, k)
			end
		end
		table.sort(themeList)
	end
	if #themeList == 0 then
		themeList = { "Aqua", "Aubergine", "Banana", "Blossom", "Hyper", "Magic", "Pastel" }
	end
end

local defaultTheme = themeList[1]
for _, n in ipairs(themeList) do
	if n == "Aqua" then
		defaultTheme = n
	end
end

TMisc:Module("界面", "主题切换 / 卸载脚本")

TMisc:CreateSelector({
	Name = "UI 主题",
	Options = themeList,
	Default = defaultTheme,
	Callback = function(v)
		pcall(function()
			Window:SetTheme(v)
		end)
	end,
})

TMisc:CreateButton({
	Name = "卸载脚本",
	Callback = function()
		pcall(function()
			if getEnv().ZakaHubUnload then
				getEnv().ZakaHubUnload()
			end
		end)
	end,
})

--======================================================================
-- [10] 主循环 & 输入
--======================================================================
local conns = {}
local function addConn(c)
	table.insert(conns, c)
	return c
end

-- 悬浮球 (双击 ↔ 单击)
quickActions = function()
	local q = S.UI.Quick
	if q == "自瞄" then
		aimToggle:Set(not S.Aim.Enabled)
	elseif q == "ESP" then
		espToggle:Set(not S.ESP.Enabled)
	elseif q == "飞行" then
		flyToggle:Set(not S.Fly.Enabled)
	elseif q == "子弹追踪" then
		silentToggle:Set(not S.Silent.Enabled)
	end
	local state = S.Silent.Enabled
	if q == "自瞄" then
		state = S.Aim.Enabled
	elseif q == "ESP" then
		state = S.ESP.Enabled
	elseif q == "飞行" then
		state = S.Fly.Enabled
	end
	Window:Notify({
		Title = q,
		Content = state and "ON" or "OFF",
		Duration = 1.5,
	})
end

createBall(function()
	Window:Toggle()
end)

-- 自瞄按键按住检测
addConn(UIS.InputBegan:Connect(function(input, processed)
	if processed then
		return
	end
	if input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode.Name == S.Aim.Key then
		S.Aim.Holding = true
	end
	-- [Zaka 补丁 4] 手机: 按住屏幕 = 按住自瞄键
	if S.Aim.Key == TOUCH_KEY and input.UserInputType == Enum.UserInputType.Touch then
		S.Aim.Holding = true
	end
end))

addConn(UIS.InputEnded:Connect(function(input)
	if input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode.Name == S.Aim.Key then
		S.Aim.Holding = false
	end
	if S.Aim.Key == TOUCH_KEY and input.UserInputType == Enum.UserInputType.Touch then
		S.Aim.Holding = false
	end
end))

-- 无限跳跃
addConn(UIS.JumpRequest:Connect(function()
	if S.Move.InfJump then
		local hum = getHum()
		if hum then
			pcall(function()
				hum:ChangeState(Enum.HumanoidStateType.Jumping)
			end)
		end
	end
end))

-- 防挂机
if LP.Idled then
	addConn(LP.Idled:Connect(function()
		if not S.Move.AntiAFK then
			return
		end
		pcall(function()
			mousemoverel(2, 0)
			mousemoverel(-2, 0)
		end)
	end))
end

-- 角色重生时重新应用
addConn(LP.CharacterAdded:Connect(function(char)
	task.wait(1)
	restoreNoclip()
	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then
		pcall(function()
			hum.WalkSpeed = S.Move.SpeedEnabled and S.Move.WalkSpeed or 16
			if S.Move.JumpEnabled then
				hum.UseJumpPower = true
				hum.JumpPower = S.Move.JumpPower
			end
		end)
	end
	if S.Fly.Enabled then
		stopFly()
	end
end))

addConn(Players.PlayerRemoving:Connect(function(plr)
	local d = espCache[plr]
	if d then
		destroyESPData(d)
		espCache[plr] = nil
	end
end))

-- 自瞄挂在相机更新之后执行, 免得被默认相机脚本覆盖掉
local aimBound = false
local function runAimStep()
	local aimActive = S.Aim.Enabled and (S.Aim.Always or S.Aim.Holding)
	if not aimActive then
		return
	end
	local target = findTarget(S.Aim, false)
	if target then
		applyAim(target)
	end
end

pcall(function()
	RunService:UnbindFromRenderStep("ZakaHubAimStep")
	RunService:BindToRenderStep("ZakaHubAimStep", Enum.RenderPriority.Camera.Value + 1, function()
		pcall(runAimStep)
	end)
	aimBound = true
end)

-- 主循环
local accTick = 0
addConn(RunService.RenderStepped:Connect(function(dt)
	-- 自瞄 (若上面绑定失败则走这里兜底)
	if not aimBound then
		pcall(runAimStep)
	end

	-- FOV 圈
	if fovCircle then
		local showCircle = S.Aim.ShowFOV and S.Aim.Enabled and DRAWING
		fovCircle.Visible = showCircle and true or false
		if showCircle then
			fovCircle.Position = getAimCenter()
			fovCircle.Radius = S.Aim.FOV
			fovCircle.Color = S.ESP.Color
			fovCircle.Transparency = 0.65
		end
	end

	-- ESP (限速到 ~60fps 已经够, 每帧跑)
	updateESP()

	-- 移动
	if S.Fly.Enabled then
		updateFly()
	elseif flyBV then
		stopFly()
	end

	applyMovement()

	accTick = accTick + dt
	if accTick >= 0.25 then
		accTick = 0
		updateNoclip()
	end
end))

--======================================================================
-- [11] 卸载
--======================================================================
getEnv().ZakaHubUnload = function()
	pcall(function()
		for _, c in ipairs(conns) do
			c:Disconnect()
		end
	end)
	conns = {}

	pcall(function()
		RunService:UnbindFromRenderStep("ZakaHubAimStep")
	end)

	pcall(clearESP)
	pcall(restoreNoclip)
	pcall(stopFly)
	pcall(removeSilentHook)
	pcall(destroyBall)

	if fovCircle then
		pcall(function()
			fovCircle:Remove()
		end)
		fovCircle = nil
	end

	pcall(function()
		Window:Destroy()
	end)

	getEnv().ZakaHubUnload = nil
	print("[Zaka Hub] 已卸载")
end

Window:Notify({
	Title = "Zaka Hub 已加载",
	Content = IS_TOUCH and "点悬浮球开关菜单 · 按住屏幕自瞄" or "RightShift 开关菜单 · 悬浮球可拖动",
	Duration = 5,
})

print("[Zaka Hub] 加载完成 | 触摸端: " .. tostring(IS_TOUCH) .. " | Drawing: " .. tostring(DRAWING ~= nil) .. " | Hook: " .. tostring(HOOKFUNC ~= nil))
