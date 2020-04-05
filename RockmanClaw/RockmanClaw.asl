state("fceux") {
	byte boss_hp : 0x436B04, 0x6C1;
	byte music : 0x436B04, 0x501;
	byte note : 0x436B04, 0x500;
	byte stage : 0x436B04, 0x31;
	byte boss_id : 0x436B04, 0xAC;
	byte timer: 0x436B04, 0x3C;
}

state("nestopia") {
	// base 0x0000 address of ROM : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x68;
	// just add your fceux offset to 0x68 to get the final nestopia offset
	byte boss_hp : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x729;
	byte music : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x569;
	byte note : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x568;
	byte stage : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x99;
	byte boss_id : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0x114;
	byte timer : "nestopia.exe", 0x1b2bcc, 0, 8, 0xc, 0xc, 0xA4;
}

state("X-Zone") {
    // C6B188
    byte boss_hp : "emulib3.dll", 0xC6B849;
    byte music : "emulib3.dll", 0xC6B689;
    byte note : "emulib3.dll", 0xC6B688;
    byte stage : "emulib3.dll", 0xC6B1B9;
    byte boss_id : "emulib3.dll", 0xC6B234;
    byte timer : "emulib3.dll", 0xC6B1C4;
}

init {
	refreshRate = 60;
}

startup {
    settings.Add("info", true, "---Info---");
    settings.Add("info_1", true, "supported: FCEUX, Nestopia(maybe), Gotvg", "info");
}

start {
	return current.stage == 10 && current.timer != 0;
}

reset {
	return current.stage == 10 && current.timer == 0 && current.xpos == 0;
}

split {
    if (current.stage < 9) {
        return current.music == 157 && current.note == 117 && old.note != 117;
    } else {
        return current.boss_hp == 0 && old.boss_hp > 0 && current.boss_id == 10;
    }
}
