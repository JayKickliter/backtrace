##########################################################################
# Ping-Pong                                                              #
##########################################################################
add_executable(pingpong
  ping-pong.c
  )

target_compile_options(pingpong
  PUBLIC
  -fno-omit-frame-pointer
  -funwind-tables
  -mcpu=cortex-m3
  -mthumb
  -nostdlib
  -mpoke-function-name
  )

target_link_options(pingpong
  PRIVATE
  --specs=rdimon.specs
  --specs=nano.specs
  )
target_link_libraries(pingpong backtrace)


##########################################################################
# Hello                                                                  #
##########################################################################
add_executable(hello
  hello.c
  )

set_target_properties(hello
  PROPERTIES
  LINK_DEPENDS ${CMAKE_CURRENT_LIST_DIR}/lm3s6965.ld
  )

target_compile_options(hello
  PUBLIC
  --specs=nano.specs
  --specs=rdimon.specs
  -fdata-sections
  -ffunction-sections
  -mcpu=cortex-m3
  -mfloat-abi=softfp
  -mthumb
  )

target_link_options(hello
  PRIVATE
  --specs=nano.specs
  --specs=rdimon.specs
  -fdata-sections
  -ffunction-sections
  -mcpu=cortex-m3
  -mfloat-abi=softfp
  -mthumb
  -T ${CMAKE_CURRENT_LIST_DIR}/lm3s6965.ld
  -Wl,--gc-sections
  )
