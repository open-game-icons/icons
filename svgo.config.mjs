export default {
  plugins: [
    "preset-default",
    "convertStyleToAttrs",
    "removeDimensions",
    "removeTitle",
    {
      name: "removeAttrs",
      params: {
        attrs: [
          "fill-opacity",
          "stroke-opacity",
          "stop-opacity",
          "opacity",
          "overflow",
          "paint-order",
          "*:fill:none",
          "fill-rule",
          "stroke-miterlimit",
          "clip-rule",
          "stroke-linejoin",
        ],
      },
    },
  ],
};
