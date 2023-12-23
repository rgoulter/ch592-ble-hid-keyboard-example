CH592 BLE HID Keyboard
======================

The BLE/HID_Keyboard example from the `openwch/ch592 <https://github.com/openwch/ch592>`_ EVT,
in its own repo, with a ``Makefile`` and a ``shell.nix`` added
so it's easier to build without needing MounRiver Studio.

The ``shell.nix`` uses `the nix package manager <https://nixos.org/>`_,
and provides the MounRiver toolchain, as well as the newer ``riscv-none-elf-gcc`` xpack toolchain, and `wchisp <https://github.com/ch32-rs/wchisp>`_. Enter the nix shell using either ``nix-shell``, or ``nix develop`` if using nix flakes.

If not using nix, download either `MounRiver <http://www.mounriver.com/download>`_, or a more recent `xpack of riscv-none-elf-gcc <https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack>`_.

Run the ``Makefile`` using ``make``.

The firmware can be flashed to the CH592 using ``wchisp``. (Enter the CH592 bootloader by holding down BOOT when connecting it using USB).

The SDK for CH592 from the openwch EVT is vendored under ``sdk/``. (Encoding has been changed from gbk to utf-8).
