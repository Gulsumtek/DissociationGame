extends CanvasLayer

func _ready():
	# 1. Aşama: İşletim sistemi kontrolü
	var os_name = OS.get_name()
	
	# Mobil platformlar dışındaysa doğrudan gizle
	if os_name != "Android" and os_name != "iOS":
		# Eğer HTML5 (Web) çıktı aldıysak ve mobil tarayıcıdadaysak burası çalışmamalı, 
		# bu yüzden web durumunu ekstradan kontrol ediyoruz:
		if os_name == "Web":
			# Web üzerindeyken cihaz gerçekten dokunmatik destekli bir mobil mi?
			if DisplayServer.has_feature(DisplayServer.FEATURE_TOUCHSCREEN):
				show() # Mobil tarayıcı, butonları göster
				return
		
		# Yukarıdaki şartlara uymayan tüm masaüstü/editör durumlarında butonları gizle
		hide()
	else:
		# Doğrudan Android veya iOS cihazda çalışıyorsa göster
		show()
