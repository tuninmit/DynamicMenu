#Requires AutoHotkey v2.0
OneLinkItem := ItemMenu.parseFromString("OneLink|10.15.199.17|OneLink")

onelinkDynamicItems := Array()
onelinkDynamicItems.Push(ItemMenu.parseFromString('x|10.15.199.17|', false))
onelinkDynamicItems.Push(ItemMenu.parseFromString('tail|10.15.199.17|', false))

onelinkDynamicItems.Push(ItemMenu.parseFromString('webbapp|10.15.199.17|', false, true))
onelinkDynamicItems.Push(ItemMenu.parseFromString('1|10.15.199.17|Send###tail -1000f /opt/one/logs/webapp.log'))

onelinkDynamicItems.Push(ItemMenu.parseFromString('apigw|10.15.199.17|', false, true))
onelinkDynamicItems.Push(ItemMenu.parseFromString('2|10.15.199.17|Send###tail -1000f /opt/one/logs/apigw.log'))

onelinkDynamicItems.Push(ItemMenu.parseFromString('authen|10.15.199.17|', false, true))
onelinkDynamicItems.Push(ItemMenu.parseFromString('3|10.15.199.17|Send###tail -1000f /opt/one/logs/authen.log'))

OneLinkItem.setChild(onelinkDynamicItems)


