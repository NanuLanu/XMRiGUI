.PHONY: build install uninstall clean deb py-install py-deb

package = rtmgui_1.2-2_amd64
py-package = rtmgui_1.2-2-python_amd64

build:
	pyinstaller --onefile -w rtmgui.py
	./detect_cpu.sh

install:
	cp dist/rtmgui /usr/local/bin/
	mkdir -p /opt/rtmgui
	cp cpuminer /opt/rtmgui/
	mkdir -p /usr/share/icons/hicolor/256x256/apps
	cp rtmgui.png /usr/share/icons/hicolor/256x256/apps/
	cp rtmgui.desktop /usr/share/applications/
	cp org.freedesktop.policykit.rtmgui.policy /usr/share/polkit-1/actions/

uninstall:
	rm /usr/local/bin/rtmgui
	rm -rf /opt/rtmgui
	rm /usr/share/icons/hicolor/256x256/apps/rtmgui.png
	rm /usr/share/applications/rtmgui.desktop
	rm /usr/share/polkit-1/actions/org.freedesktop.policykit.rtmgui.policy

clean:
	rm -rf __pycache__
	rm -rf build
	rm -rf dist
	rm -rf rtmgui.spec
	rm -rf cpuminer

deb:
	mkdir -p $(package)/usr/local/bin/
	mkdir -p $(package)/opt/rtmgui/
	mkdir -p $(package)/usr/share/icons/hicolor/256x256/apps/
	mkdir -p $(package)/usr/share/applications/
	cp dist/rtmgui $(package)/usr/local/bin/
	cp cpuminer $(package)/opt/rtmgui/
	cp rtmgui.png $(package)/usr/share/icons/hicolor/256x256/apps/
	cp rtmgui.desktop $(package)/usr/share/applications/
	dpkg-deb --build --root-owner-group $(package)
	rm $(package)/usr/local/bin/*
	rm $(package)/opt/rtmgui/*
	rm $(package)/usr/share/icons/hicolor/256x256/apps/*
	rm $(package)/usr/share/applications/*

py-install:
	./detect_cpu.sh
	cp rtmgui.py /usr/local/bin/rtmgui
	mkdir -p /opt/rtmgui
	cp cpuminer /opt/rtmgui/
	mkdir -p /usr/share/icons/hicolor/256x256/apps
	cp rtmgui.png /usr/share/icons/hicolor/256x256/apps/
	cp rtmgui.desktop /usr/share/applications/
	cp org.freedesktop.policykit.rtmgui.policy /usr/share/polkit-1/actions/

py-deb:
	./detect_cpu.sh
	mkdir -p $(py-package)/usr/local/bin/
	mkdir -p $(py-package)/opt/rtmgui/
	mkdir -p $(py-package)/usr/share/icons/hicolor/256x256/apps/
	mkdir -p $(py-package)/usr/share/applications/
	cp rtmgui.py $(py-package)/usr/local/bin/rtmgui
	cp cpuminer $(py-package)/opt/rtmgui/
	cp rtmgui.png $(py-package)/usr/share/icons/hicolor/256x256/apps/
	cp rtmgui.desktop $(py-package)/usr/share/applications/
	dpkg-deb --build --root-owner-group $(py-package)
	rm $(py-package)/usr/local/bin/*
	rm $(py-package)/opt/rtmgui/*
	rm $(py-package)/usr/share/icons/hicolor/256x256/apps/*
	rm $(py-package)/usr/share/applications/rtmgui.desktop