indexing

	description:
   
		"Database for mapping to lowercase"

	note:
   
		"This file generated by a script from the Unicode %
		%database and beautified by hand and emacs"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001, Michael Kretschmar and others"
	license: "Eiffel Forum License v1 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"
   
class UC_CTYPE_LOWERCASE

feature {UC_CTYPE} -- Lowercase conversion tables

	lowercase_00: ARRAY [INTEGER] is
		once
			Result := <<
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,97,98,99,
		     100,101,102,103,
		     104,105,106,107,
		     108,109,110,111,
		     112,113,114,115,
		     116,117,118,119,
		     120,121,122,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     224,225,226,227,
		     228,229,230,231,
		     232,233,234,235,
		     236,237,238,239,
		     240,241,242,243,
		     244,245,246,-1,
		     248,249,250,251,
		     252,253,254,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1
		     >>
		end

	lowercase_01: ARRAY [INTEGER] is
		once
			Result := <<
		     257,-1,259,-1,
		     261,-1,263,-1,
		     265,-1,267,-1,
		     269,-1,271,-1,
		     273,-1,275,-1,
		     277,-1,279,-1,
		     281,-1,283,-1,
		     285,-1,287,-1,
		     289,-1,291,-1,
		     293,-1,295,-1,
		     297,-1,299,-1,
		     301,-1,303,-1,
		     105,-1,307,-1,
		     309,-1,311,-1,
		     -1,314,-1,316,
		     -1,318,-1,320,
		     -1,322,-1,324,
		     -1,326,-1,328,
		     -1,-1,331,-1,
		     333,-1,335,-1,
		     337,-1,339,-1,
		     341,-1,343,-1,
		     345,-1,347,-1,
		     349,-1,351,-1,
		     353,-1,355,-1,
		     357,-1,359,-1,
		     361,-1,363,-1,
		     365,-1,367,-1,
		     369,-1,371,-1,
		     373,-1,375,-1,
		     255,378,-1,380,
		     -1,382,-1,-1,
		     -1,595,387,-1,
		     389,-1,596,392,
		     -1,598,599,396,
		     -1,-1,477,601,
		     603,402,-1,608,
		     611,-1,617,616,
		     409,-1,-1,-1,
		     623,626,-1,629,
		     417,-1,419,-1,
		     421,-1,640,424,
		     -1,643,-1,-1,
		     429,-1,648,432,
		     -1,650,651,436,
		     -1,438,-1,658,
		     441,-1,-1,-1,
		     445,-1,-1,-1,
		     -1,-1,-1,-1,
		     454,454,-1,457,
		     457,-1,460,460,
		     -1,462,-1,464,
		     -1,466,-1,468,
		     -1,470,-1,472,
		     -1,474,-1,476,
		     -1,-1,479,-1,
		     481,-1,483,-1,
		     485,-1,487,-1,
		     489,-1,491,-1,
		     493,-1,495,-1,
		     -1,499,499,-1,
		     501,-1,405,447,
		     505,-1,507,-1,
		     509,-1,511,-1
		     >>
		end

	lowercase_02: ARRAY [INTEGER] is
		once
			Result := <<
		     513,-1,515,-1,
		     517,-1,519,-1,
		     521,-1,523,-1,
		     525,-1,527,-1,
		     529,-1,531,-1,
		     533,-1,535,-1,
		     537,-1,539,-1,
		     541,-1,543,-1,
		     -1,-1,547,-1,
		     549,-1,551,-1,
		     553,-1,555,-1,
		     557,-1,559,-1,
		     561,-1,563,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1
		     >>
		end

	lowercase_03: ARRAY [INTEGER] is
		once
			Result := <<
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,940,-1,
		     941,942,943,-1,
		     972,-1,973,974,
		     -1,945,946,947,
		     948,949,950,951,
		     952,953,954,955,
		     956,957,958,959,
		     960,961,-1,963,
		     964,965,966,967,
		     968,969,970,971,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,987,-1,
		     989,-1,991,-1,
		     993,-1,995,-1,
		     997,-1,999,-1,
		     1001,-1,1003,-1,
		     1005,-1,1007,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1
		     >>
		end

	lowercase_04: ARRAY [INTEGER] is
		once
			Result := <<
		     1104,1105,1106,1107,
		     1108,1109,1110,1111,
		     1112,1113,1114,1115,
		     1116,1117,1118,1119,
		     1072,1073,1074,1075,
		     1076,1077,1078,1079,
		     1080,1081,1082,1083,
		     1084,1085,1086,1087,
		     1088,1089,1090,1091,
		     1092,1093,1094,1095,
		     1096,1097,1098,1099,
		     1100,1101,1102,1103,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     1121,-1,1123,-1,
		     1125,-1,1127,-1,
		     1129,-1,1131,-1,
		     1133,-1,1135,-1,
		     1137,-1,1139,-1,
		     1141,-1,1143,-1,
		     1145,-1,1147,-1,
		     1149,-1,1151,-1,
		     1153,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     1165,-1,1167,-1,
		     1169,-1,1171,-1,
		     1173,-1,1175,-1,
		     1177,-1,1179,-1,
		     1181,-1,1183,-1,
		     1185,-1,1187,-1,
		     1189,-1,1191,-1,
		     1193,-1,1195,-1,
		     1197,-1,1199,-1,
		     1201,-1,1203,-1,
		     1205,-1,1207,-1,
		     1209,-1,1211,-1,
		     1213,-1,1215,-1,
		     -1,1218,-1,1220,
		     -1,-1,-1,1224,
		     -1,-1,-1,1228,
		     -1,-1,-1,-1,
		     1233,-1,1235,-1,
		     1237,-1,1239,-1,
		     1241,-1,1243,-1,
		     1245,-1,1247,-1,
		     1249,-1,1251,-1,
		     1253,-1,1255,-1,
		     1257,-1,1259,-1,
		     1261,-1,1263,-1,
		     1265,-1,1267,-1,
		     1269,-1,-1,-1,
		     1273,-1,-1,-1,
		     -1,-1,-1,-1
		     >>
		end

	lowercase_05: ARRAY [INTEGER] is
		once
			Result := <<
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,1377,1378,1379,
		     1380,1381,1382,1383,
		     1384,1385,1386,1387,
		     1388,1389,1390,1391,
		     1392,1393,1394,1395,
		     1396,1397,1398,1399,
		     1400,1401,1402,1403,
		     1404,1405,1406,1407,
		     1408,1409,1410,1411,
		     1412,1413,1414,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1
		     >>
		end

	lowercase_06: ARRAY [INTEGER] is
		once
			Result := <<
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1
		     >>
		end

	lowercase_1e: ARRAY [INTEGER] is
		once
			Result := <<
		     7681,-1,7683,-1,
		     7685,-1,7687,-1,
		     7689,-1,7691,-1,
		     7693,-1,7695,-1,
		     7697,-1,7699,-1,
		     7701,-1,7703,-1,
		     7705,-1,7707,-1,
		     7709,-1,7711,-1,
		     7713,-1,7715,-1,
		     7717,-1,7719,-1,
		     7721,-1,7723,-1,
		     7725,-1,7727,-1,
		     7729,-1,7731,-1,
		     7733,-1,7735,-1,
		     7737,-1,7739,-1,
		     7741,-1,7743,-1,
		     7745,-1,7747,-1,
		     7749,-1,7751,-1,
		     7753,-1,7755,-1,
		     7757,-1,7759,-1,
		     7761,-1,7763,-1,
		     7765,-1,7767,-1,
		     7769,-1,7771,-1,
		     7773,-1,7775,-1,
		     7777,-1,7779,-1,
		     7781,-1,7783,-1,
		     7785,-1,7787,-1,
		     7789,-1,7791,-1,
		     7793,-1,7795,-1,
		     7797,-1,7799,-1,
		     7801,-1,7803,-1,
		     7805,-1,7807,-1,
		     7809,-1,7811,-1,
		     7813,-1,7815,-1,
		     7817,-1,7819,-1,
		     7821,-1,7823,-1,
		     7825,-1,7827,-1,
		     7829,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     7841,-1,7843,-1,
		     7845,-1,7847,-1,
		     7849,-1,7851,-1,
		     7853,-1,7855,-1,
		     7857,-1,7859,-1,
		     7861,-1,7863,-1,
		     7865,-1,7867,-1,
		     7869,-1,7871,-1,
		     7873,-1,7875,-1,
		     7877,-1,7879,-1,
		     7881,-1,7883,-1,
		     7885,-1,7887,-1,
		     7889,-1,7891,-1,
		     7893,-1,7895,-1,
		     7897,-1,7899,-1,
		     7901,-1,7903,-1,
		     7905,-1,7907,-1,
		     7909,-1,7911,-1,
		     7913,-1,7915,-1,
		     7917,-1,7919,-1,
		     7921,-1,7923,-1,
		     7925,-1,7927,-1,
		     7929,-1,-1,-1,
		     -1,-1,-1,-1
		     >>
		end

	lowercase_1f: ARRAY[INTEGER] is
		once
			Result := <<
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     7936,7937,7938,7939,
		     7940,7941,7942,7943,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     7952,7953,7954,7955,
		     7956,7957,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     7968,7969,7970,7971,
		     7972,7973,7974,7975,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     7984,7985,7986,7987,
		     7988,7989,7990,7991,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     8000,8001,8002,8003,
		     8004,8005,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,8017,-1,8019,
		     -1,8021,-1,8023,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     8032,8033,8034,8035,
		     8036,8037,8038,8039,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     8064,8065,8066,8067,
		     8068,8069,8070,8071,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     8080,8081,8082,8083,
		     8084,8085,8086,8087,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     8096,8097,8098,8099,
		     8100,8101,8102,8103,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     8112,8113,8048,8049,
		     8115,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     8050,8051,8052,8053,
		     8131,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     8144,8145,8054,8055,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     8160,8161,8058,8059,
		     8165,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     8056,8057,8060,8061,
		     8179,-1,-1,-1
		     >>
		end

	lowercase_21: ARRAY [INTEGER] is
		once
			Result := <<
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,969,-1,
		     -1,-1,107,229,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     8560,8561,8562,8563,
		     8564,8565,8566,8567,
		     8568,8569,8570,8571,
		     8572,8573,8574,8575,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1
		     >>
	end

	lowercase_24: ARRAY [INTEGER] is
		once
			Result := <<
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,9424,9425,
		     9426,9427,9428,9429,
		     9430,9431,9432,9433,
		     9434,9435,9436,9437,
		     9438,9439,9440,9441,
		     9442,9443,9444,9445,
		     9446,9447,9448,9449,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1
		     >>
		end

	lowercase_ff: ARRAY [INTEGER] is
		once
			Result := <<
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,65345,65346,65347,
		     65348,65349,65350,65351,
		     65352,65353,65354,65355,
		     65356,65357,65358,65359,
		     65360,65361,65362,65363,
		     65364,65365,65366,65367,
		     65368,65369,65370,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1,
		     -1,-1,-1,-1
		     >>
		end

	lowercase: ARRAY [ARRAY [INTEGER]] is
		once
			Result := <<
		     lowercase_00, lowercase_01, lowercase_02, lowercase_03,
		     lowercase_04, lowercase_05, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_1e, lowercase_1f,
		     lowercase_06, lowercase_21, lowercase_06, lowercase_06,
		     lowercase_24, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_06,
		     lowercase_06, lowercase_06, lowercase_06, lowercase_ff
		     >>
		end

--integer used: 3328

end
