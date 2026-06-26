

function Start()
   
        local ui = UnityEngine.GameObject.Find("UISystem")
        if ui ~= nil then
            local chat = ui.transform:Find("Canvas/UIRoot/Bottom/MainInputPanel(Clone)/ObserverNotHideLayer") -- 聊天界面
            if chat ~= nil then
                chat.gameObject:SetActive(active)
            end
        end
end    

