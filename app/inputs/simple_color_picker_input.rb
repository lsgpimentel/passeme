class SimpleColorPickerInput < SimpleForm::Inputs::CollectionSelectInput

  COLORS = {
    Navy: '#000080',
    Blue: '#0000FF',
    Green: '#008000',
    DarkCyan: '#008B8B',
    DeepSkyBlue: '#00BFFF',
    DarkTurquoise: '#00CED1',
    SpringGreen: '#00FF7F',
    Aqua: '#00FFFF',
    MidnightBlue: '#191970',
    DodgerBlue: '#1E90FF',
    LightSeaGreen: '#20B2AA',
    ForestGreen: '#228B22',
    Turquoise: '#40E0D0',
    RoyalBlue: '#4169E1',
    SteelBlue: '#4682B4',
    DarkSlateBlue: '#483D8B',
    Indigo: '#4B0082',
    DarkOliveGreen: '#556B2F',
    CadetBlue: '#5F9EA0',
    CornflowerBlue: '#6495ED',
    MediumAquaMarine: '#66CDAA',
    DimGray: '#696969',
    SlateBlue: '#6A5ACD',
    OliveDrab: '#6B8E23',
    SlateGray: '#708090',
    MediumSlateBlue: '#7B68EE',
    Chartreuse: '#7FFF00',
    Aquamarine: '#7FFFD4',
    Maroon: '#800000',
    Purple: '#800080',
    Olive: '#808000',
    Gray: '#808080',
    SkyBlue: '#87CEEB',
    LightSkyBlue: '#87CEFA',
    BlueViolet: '#8A2BE2',
    DarkRed: '#8B0000',
    DarkMagenta: '#8B008B',
    SaddleBrown: '#8B4513',
    DarkSeaGreen: '#8FBC8F',
    LightGreen: '#90EE90',
    MediumPurple: '#9370DB',
    DarkViolet: '#9400D3',
    PaleGreen: '#98FB98',
    DarkOrchid: '#9932CC',
    YellowGreen: '#9ACD32',
    Sienna: '#A0522D',
    Brown: '#A52A2A',
    DarkGray: '#A9A9A9',
    GreenYellow: '#ADFF2F',
    PaleTurquoise: '#AFEEEE',
    LightSteelBlue: '#B0C4DE',
    FireBrick: '#B22222',
    DarkGoldenRod: '#B8860B',
    MediumOrchid: '#BA55D3',
    RosyBrown: '#BC8F8F',
    DarkKhaki: '#BDB76B',
    Silver: '#C0C0C0',
    MediumVioletRed: '#C71585',
    IndianRed: '#CD5C5C',
    Peru: '#CD853F',
    Chocolate: '#D2691E',
    Tan: '#D2B48C'
  }

  def input_html_classes
    super.push('color-picker')
  end

  def collection
    COLORS
  end

end
