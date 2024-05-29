# Food Collecting Game in x86 Assembly (NASM) - DOSBox

Welcome to the Food Collecting Game, a classic gaming experience implemented in x86 Assembly language using NASM and designed to run on DOSBox.

## Overview

This retro-style game allows you to collect food items in a pixelated world while avoiding obstacles and challenges. It's a fun and nostalgic journey back to the early days of gaming.


https://github.com/afaq-ahmed07/Food-Collector_Assembly_Language/assets/118903041/648cc268-a440-47e6-ac1e-7fb2d2af8356




## Getting Started

Follow these steps to set up and play the Food Collecting Game on your system:

### Prerequisites

1. **DOSBox**: Ensure you have DOSBox installed on your system. You can download it from [DOSBox](https://www.dosbox.com/).

2. **NASM (Netwide Assembler)**: Make sure you have NASM installed to assemble the game code. You can download NASM from [NASM](https://www.nasm.us/).

### Installation

1. Clone the game repository to your local machine.

    ```bash
    git clone https://github.com/afaq-ahmed07/Food-Collector_Assembly_Language.git
    ```

2. Open DOSBox and mount the directory where the game code is located. For example:

    ```bash
    mount c /path/to/food-collecting-game
    c:
    ```

### Playing the Game

1. Assemble the game code using NASM:

    ```bash
    nasm -f bin FOOD_COL.asm -o FOOD_COL.com
    ```

2. Run the game in DOSBox:

    ```bash
    FOOD_COL.com
    ```

3. Enjoy collecting food items and mastering the challenges of the game!

## Controls

- Use arrow keys for movement.
- Collect food items to earn points.
- Avoid obstacles and adversaries.

## Contributing

Contributions to enhance or expand the game are welcome. Feel free to submit pull requests and open issues for collaboration.


If you have any questions or need assistance while playing the game, don't hesitate to reach out. Have a great time collecting food and reliving the nostalgia of classic gaming!
