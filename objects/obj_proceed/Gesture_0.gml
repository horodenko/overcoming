switch (global.storeProceed) {
	case 0: 
		room_goto(Underground);
		break;
	case 1: 
		room_goto(Second_Level);
		break;
	case 2:
		room_goto(Final_Level);
		break;
}