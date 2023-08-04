extends ColorRect


var citaions_minus = - 1
var good_player_bonus = 1.5

func _ready():
	BgAudio.play_sound("res://Assets/Sounds/cc_bgm_change.ogg")
	Global.total_days += 1
	$DayCompletedLbl.text = "Day " + String(Global.total_days)
	#Recipte for the day
	$DayCompletedLbl/ColorRect/totalOverallLbl/totalOverallLbl2.text = String(Global.total_deliveries)
	$DayCompletedLbl/ColorRect/totoalTDayLbl/totoalTDayLbl2.text = String(Global.num_of_deliveries)
	$DayCompletedLbl/ColorRect/citaionsLbl/citaionsLbl2.text = String(Global.num_of_citations)
	if Global.good_player_bonus > 5:
		$DayCompletedLbl/ColorRect/GPlyaerBonusLbl/GPlyaerBonusLbl2.text = "x1.5"
	else:
		$DayCompletedLbl/ColorRect/GPlyaerBonusLbl/GPlyaerBonusLbl2.text = "x0"
		
		
	#UPdating Money
	Global.player_money += (Global.num_of_citations * citaions_minus)
	if Global.good_player_bonus > 0:
		Global.player_money *= 1.5
		Global.player_money = ceil(Global.player_money)
		
	if Global.player_money < 0:
		print(Global.player_money)
		Global.player_money = 0
		
	Global.player_total_money += Global.player_money
	
	$DayCompletedLbl/ColorRect/MoneyEarned/MoneyEarned.text = String(Global.player_money)
	$Shoppe/LblCurrentMoney.text = "Current Money: $" + String(Global.player_total_money)
	#Updating Shoppe
	if Global.upgrade_transmission == 0 or Global.transmission_price > Global.player_total_money:
		$Shoppe/TranmissionLbl/transmission_upgrade_btn.disabled = true
		
	if Global.upgrade_engine == 0 or Global.engine_price > Global.player_total_money:
		$Shoppe/EngineLbl/EngineUpgradeBtn.disabled = true
		
	if Global.upgrade_engine == 0 and Global.upgrade_transmission == 0:
		$Shoppe/UpgradeCarLbl.visible = true
		
	$Shoppe/TranmissionLbl.text += String(Global.transmission_price)
	$Shoppe/EngineLbl.text += String(Global.engine_price)


func _on_transmission_upgrade_btn_pressed():
	if Global.transmission_price <= Global.player_total_money:
		Global.upgrade_transmissio()
		Global.upgrade_transmission -= 1
		
		Global.player_total_money -= Global.transmission_price
		Global.transmission_price *= 1.5
		Global.transmission_price = ceil(Global.transmission_price)
		
		if Global.upgrade_transmission == 0 or Global.player_total_money < Global.transmission_price:
			$Shoppe/TranmissionLbl/transmission_upgrade_btn.disabled = true
		$Shoppe/TranmissionLbl.text = "Transmission: $" +  String(Global.transmission_price)
		$Shoppe/LblCurrentMoney.text = "Current Money: $" + String(Global.player_total_money)
	else:
		$Shoppe/TranmissionLbl/transmission_upgrade_btn.disabled = true
func _on_EngineUpgradeBtn_pressed():
	if Global.engine_price <= Global.player_total_money:
		Global.upgrade_engin()
		Global.upgrade_engine -= 1

		Global.player_total_money -= Global.engine_price
		Global.engine_price *= 1.5
		Global.engine_price = ceil(Global.engine_price)

		if Global.upgrade_engine == 0 or Global.player_total_money < Global.engine_price:
			$Shoppe/EngineLbl/EngineUpgradeBtn.disabled = true
		$Shoppe/EngineLbl.text = "Engine: $" +  String(Global.engine_price)
		$Shoppe/LblCurrentMoney.text = "Current Money: $" + String(Global.player_total_money)
	else:
		$Shoppe/EngineLbl/EngineUpgradeBtn.disabled = true
func _on_UpgradeCarBtrn_pressed():
	Global.player_has_upgraded_car = true


func _on_ContinueBtn_pressed():
	Global.reset_for_next_day()
	get_tree().change_scene("res://World.tscn")


func _on_HomeBtn_pressed():
	get_tree().change_scene("res://Menus/MainMenu.tscn")
