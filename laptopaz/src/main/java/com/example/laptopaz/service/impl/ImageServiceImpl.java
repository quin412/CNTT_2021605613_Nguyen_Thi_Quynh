package com.example.laptopaz.service.impl;

import com.example.laptopaz.domain.entity.Image;
import com.example.laptopaz.repository.ImageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ImageServiceImpl {
    private final ImageRepository imageRepository;

    public Image saveImage(Image image) {
        return imageRepository.save(image);
    }

    public void deleteImage(long id) {
        imageRepository.deleteByProductId(id);
    }
}
