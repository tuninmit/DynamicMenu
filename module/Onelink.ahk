#Requires AutoHotkey v2.0
OneLinkItem := ItemMenu.parseFromString("OneLink|10.15.199.17|OneLink")

onelinkDynamicItems := Array()
onelinkDynamicItems.Push(ItemMenu.parseFromString('-|10.15.199.17|', false))
onelinkDynamicItems.Push(ItemMenu.parseFromString('webbapp|10.15.199.17|', false))
onelinkDynamicItems.Push(ItemMenu.parseFromString('apigw|10.15.199.17|', false))
onelinkDynamicItems.Push(ItemMenu.parseFromString('authen|10.15.199.17|', false))

onelinkDynamicItems.Push(ItemMenu.parseFromString('tail|10.15.199.17|', false, true))
onelinkDynamicItems.Push(ItemMenu.parseFromString('Q|10.15.199.17|SendText###tail -1000f /opt/one/logs/webapp.log'))
onelinkDynamicItems.Push(ItemMenu.parseFromString('A|10.15.199.17|SendText###tail -1000f /opt/one/logs/apigw.log'))
onelinkDynamicItems.Push(ItemMenu.parseFromString('Z|10.15.199.17|SendText###tail -1000f /opt/one/logs/authen.log'))

OneLinkItem.setChild(onelinkDynamicItems)


