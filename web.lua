-- web.lua


-- Post URL:
-- http://192.168.1.11:8080/webadmin/GandiCraft/Gandi?action=update&name=server01&field=ipv4&value=7.77.7.7
function HandleRequest_Gandi(Request)
    
    content = "[gandiclient]"

    if Request.PostParams["action"] ~= nil then

        action = Request.PostParams["action"]


        -- Update server
        name = Request.PostParams["name"]
        field = Request.PostParams["field"]
        value = Request.PostParams["value"]

       
        if action == "update"
        then
            LOG("EVENT - update server")
            LOG("Update server with name: " .. name)
               
            if field == "ipv4" then
                local sql = "UPDATE servers SET ipv4 = ? WHERE name = ?";
                local parameters = {value, name};
                ExecuteStatement(sql, parameters);
            end 

               
            LOG("Date receive: name=" .. name .. "&field=" .. field .. "&value=" .. value )
        end

        content = content .. "{action:\"" .. action .. "\"}"

    else
        content = content .. "{error:\"action requested\"}"

    end

    content = content .. "[/gandiclient]"

    return content
end
