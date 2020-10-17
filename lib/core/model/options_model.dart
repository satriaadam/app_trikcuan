class OptionsModel<T> {
    String imageAsset;
    String imageNetwork;
    String name;
    T value;
    bool isSelected;

    OptionsModel({
        this.imageAsset,
        this.imageNetwork,
        this.name,
        this.value
    });
    
    OptionsModel.withSelected({
        this.imageAsset,
        this.imageNetwork,
        this.name,
        this.value,
        this.isSelected
    });
}
