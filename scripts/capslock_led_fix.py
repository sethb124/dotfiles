#!/bin/python3
import asyncio

from evdev import InputDevice, ecodes


async def main():
    phys = InputDevice('/dev/input/event4')
    virt = InputDevice('/dev/input/event15')
    async for ev in virt.async_read_loop():
        if (
            ev.type == 1  # key event
            and (ev.code == ecodes.KEY_ESC or ev.code == ecodes.KEY_LEFTCTRL)
            and ev.value == 1  # down
        ):
            print(repr(ev))
            # if led is lit up
            if ecodes.LED_CAPSL in phys.leds():
                phys.set_led(ecodes.LED_CAPSL, 0)
                phys.set_led(ecodes.LED_CAPSL, 1)
            else:
                phys.set_led(ecodes.LED_CAPSL, 1)
                phys.set_led(ecodes.LED_CAPSL, 0)


if __name__ == '__main__':
    asyncio.run(main())
