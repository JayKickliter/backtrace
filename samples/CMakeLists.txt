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
  --specs=rdimon.specs
  --specs=nano.specs
  )

target_link_options(pingpong
  PRIVATE
  --specs=rdimon.specs
  --specs=nano.specs
)
target_link_libraries(pingpong backtrace)
