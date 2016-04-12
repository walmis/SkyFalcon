CMAKE_ECLIPSE_FLAGS=-G"Eclipse CDT4 - Unix Makefiles" -D CMAKE_ECLIPSE_VERSION=4.5

.PHONY: all
all:  xpcc arducopter RadioHead SkyFalcon_FMU

.PHONY: clean
clean: build/xpcc/Makefile build/RadioHead/Makefile build/SkyFalcon_FMU/Makefile 
	$(MAKE) -C ardupilot/ArduCopter clean
	$(MAKE) -C build/xpcc clean
	$(MAKE) -C build/RadioHead clean
	$(MAKE) -C build/SkyFalcon_FMU clean

.PHONY: distclean	
distclean:
	rm -r build
	
build/xpcc/Makefile:
	@mkdir -p build/xpcc
	(cd build/xpcc && cmake -D CMAKE_BUILD_TYPE=MinSizeRel -D PLATFORM=stm32f4 -D CHIBI_RTOS=1 ../../xpcc)
	
build/RadioHead/Makefile:
	@mkdir -p build/RadioHead
	cd build/RadioHead && cmake -D CMAKE_BUILD_TYPE=MinSizeRel -D PLATFORM=cortex-m4 ../../RadioHead
	
build/SkyFalcon_FMU/Makefile:
	@mkdir -p build/SkyFalcon_FMU
	cd build/SkyFalcon_FMU && cmake -D CMAKE_BUILD_TYPE=MinSizeRel ../../SKYFalcon_FMU/
	
arducopter:
	$(MAKE) -C ardupilot/ArduCopter skyfalcon
	
xpcc: build/xpcc/Makefile
	$(MAKE) -C build/xpcc
	
RadioHead: build/RadioHead/Makefile
	$(MAKE) -C build/RadioHead
	
SkyFalcon_FMU:
	$(MAKE) -C build/SkyFalcon_FMU


	
.PHONY: eclipseproj
eclipseproj:
	@mkdir -p build/xpcc
	cd build/xpcc && cmake ${CMAKE_ECLIPSE_FLAGS} -D CMAKE_BUILD_TYPE=MinSizeRel -D PLATFORM=stm32f4 -D CHIBI_RTOS=1 ../../xpcc
	@mkdir -p build/RadioHead
	cd build/RadioHead && cmake ${CMAKE_ECLIPSE_FLAGS} -D CMAKE_BUILD_TYPE=MinSizeRel -D PLATFORM=cortex-m4 ../../RadioHead
	@mkdir -p build/SkyFalcon_FMU
	cd build/SkyFalcon_FMU && cmake ${CMAKE_ECLIPSE_FLAGS} -D CMAKE_BUILD_TYPE=MinSizeRel ../../SKYFalcon_FMU	
	
	
