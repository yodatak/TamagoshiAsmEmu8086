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
        unsigned int pixel_x = i%size.x,
                     pixel_y = i/size.x;

        sf::Color pixel = image.getPixel(pixel_x, pixel_y);

        unsigned int pixel_color = 0xf;///blanc par défaut
        if(pixel.r == 0 && pixel.g == 0 && pixel.b == 0)
            pixel_color = 0x0;
        else if(pixel.r == 0 && pixel.g == 0 && pixel.b == 170)
            pixel_color = 0x1;
        else if(pixel.r == 0 && pixel.g == 170 && pixel.b == 0)
            pixel_color = 0x2;
        else if(pixel.r == 0 && pixel.g == 170 && pixel.b == 170)
            pixel_color = 0x3;
        else if(pixel.r == 170 && pixel.g == 0 && pixel.b == 0)
            pixel_color = 0x4;
        else if(pixel.r == 170 && pixel.g == 0 && pixel.b == 170)
            pixel_color = 0x5;
        else if(pixel.r == 170 && pixel.g == 85 && pixel.b == 0)
            pixel_color = 0x6;
        else if(pixel.r == 170 && pixel.g == 170 && pixel.b == 170)
            pixel_color = 0x7;
        else if(pixel.r == 85 && pixel.g == 85 && pixel.b == 85)
            pixel_color = 0x8;
        else if(pixel.r == 85 && pixel.g == 85 && pixel.b == 255)
            pixel_color = 0x9;
        else if(pixel.r == 85 && pixel.g == 255 && pixel.b == 85)
            pixel_color = 0xa;
        else if(pixel.r == 85 && pixel.g == 255 && pixel.b == 255)
            pixel_color = 0xb;
        else if(pixel.r == 255 && pixel.g == 85 && pixel.b == 85)
            pixel_color = 0xc;
        else if(pixel.r == 255 && pixel.g == 85 && pixel.b == 255)
            pixel_color = 0xd;
        else if(pixel.r == 255 && pixel.g == 255 && pixel.b == 85)
            pixel_color = 0xe;
        else if(pixel.r == 255 && pixel.g == 255 && pixel.b == 255)
            pixel_color = 0xf;
        else
            std::cerr << "Attention ! Le pixel x:y " << pixel_x << ":" << pixel_y << " a une couleur non supportée : " << (int)pixel.r << "r" << (int)pixel.b << "b" << (int)pixel.g << "g" << std::endl;

        std::cout << "0" << std::hex << pixel_color << "h";

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
