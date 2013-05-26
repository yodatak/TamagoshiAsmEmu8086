#include <iostream>
#include <SFML/Graphics.hpp>

/**

    SpriteMaker : permet de transformer une image en données équivalentes dans un code assembleur 8086

    exemple d'utilisation :
    SpriteMaker.exe "../images/pikamini.jpg" "sprite_pikamini" > pikamini.txt
**/

int main(int argc, char* argv[])
{
    sf::Image image;
    image.loadFromFile(argv[1]);

    sf::Vector2u size = image.getSize();

    std::cout << argv[2] << "_w DW " << "0" << std::hex << size.x << "h" << std::endl;
    std::cout << argv[2] << "_h DW " << "0" << std::hex << size.y << "h" << std::endl;

    std::cout << argv[2] << " DB ";
    for(unsigned int i = 0; i < size.x*size.y; ++i)
    {
        std::cout << "0" << std::hex << image.getPixel(i%size.x, i/size.x).r/16 << "h";

        if(i + 1 < size.x*size.y)
        {
            if((i + 1)%size.x == 0)
                std::cout << "\n" << argv[2] << "_line_" << (i + 1)/size.x << " DB ";
            else
                std::cout << ",";
        }

    }
    std::cout << std::endl;
}
