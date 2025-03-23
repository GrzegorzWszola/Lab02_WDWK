cmake_minimum_required(VERSION 3.10)
project(AssemblerApp VERSION 1.0 LANGUAGES C ASM)  

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -m32")
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} -m32")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -m32 -no-pie")

set(ASM_SOURCE ${CMAKE_CURRENT_SOURCE_DIR}/src/Lab02_src.s)
set(C_SOURCE ${CMAKE_CURRENT_SOURCE_DIR}/src/Lab02C_src.c)

add_executable(Lab02 ${C_SOURCE} ${ASM_SOURCE})

add_custom_target(run
    COMMAND ./Lab02
    DEPENDS Lab02
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
)
