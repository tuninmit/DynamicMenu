#Requires AutoHotkey v2.0
QoeItem := ItemMenu.parseFromString("Qoe|10.15.13.162|Qoe")

qoeDynamicItems := Array()
qoeDynamicItems.Push(ItemMenu.parseFromString('-|10.15.13.162|', false))
qoeDynamicItems.Push(ItemMenu.parseFromString('webbapp|10.15.13.162|', false))
qoeDynamicItems.Push(ItemMenu.parseFromString('apigw|10.15.13.162|', false))
qoeDynamicItems.Push(ItemMenu.parseFromString('http|10.15.13.162|', false))

qoeDynamicItems.Push(ItemMenu.parseFromString('tail|10.15.13.162|', false, true))
qoeDynamicItems.Push(ItemMenu.parseFromString('Q|10.15.13.162|Send###tail -1000f /opt/one/logs/webapp.log'))
qoeDynamicItems.Push(ItemMenu.parseFromString('W|10.15.13.162|Send###tail -1000f /opt/one/logs/wifiqoe-api.log'))
qoeDynamicItems.Push(ItemMenu.parseFromString('E|10.15.13.162|Send###tail -1000f /opt/one/logs/wifiqoe-http.log'))

qoeDynamicItems.Push(ItemMenu.parseFromString('restart|10.15.13.162|', false, true))
qoeDynamicItems.Push(ItemMenu.parseFromString('A|10.15.13.162|Send###systemctl restart wifiqoe-webapp.service'))
qoeDynamicItems.Push(ItemMenu.parseFromString('S|10.15.13.162|Send###systemctl restart wifiqoe-api.service'))
qoeDynamicItems.Push(ItemMenu.parseFromString('D|10.15.13.162|Send###systemctl restart wifiqoe-http.service'))

QoeItem.setChild(qoeDynamicItems)


