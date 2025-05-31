package com.example.laptopaz.service.impl;

import com.example.laptopaz.domain.dto.request.FeedbackRequestDto;
import com.example.laptopaz.domain.entity.BillDetail;
import com.example.laptopaz.domain.entity.Customer;
import com.example.laptopaz.domain.entity.FeedBack;
import com.example.laptopaz.repository.BillDetailRepository;
import com.example.laptopaz.repository.FeedBackRepository;
import com.example.laptopaz.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class FeedBackServiceImpl {
    private final FeedBackRepository feedBackRepository;
    private final BillDetailRepository billDetailRepository;
    private final ProductRepository productRepository;
    private final CustomerServiceImpl customerService;

    public Optional<Float> getAvgRateByProductId(long productId) {
        return feedBackRepository.getAvgRateByProductId(productId);
    }

    public Page<FeedBack> findByProductId(long productId, Pageable pageable) {
        return feedBackRepository.findAllByProductId(productId, pageable);
    }

    public void giveFeedBack(FeedbackRequestDto requestDto) {
        Customer customer = customerService.getCurrentCustomer();
        BillDetail bill = billDetailRepository.findById(requestDto.getBillDetaiId()).orElse(null);
        FeedBack feedBack = new FeedBack();
        feedBack.setContent(requestDto.getContent());
        feedBack.setRate(requestDto.getRate());
        feedBack.setCreatedDate(LocalDateTime.ofInstant(new Date().toInstant(), ZoneId.systemDefault()));
        feedBack.setLastModifiedDate(LocalDateTime.ofInstant(new Date().toInstant(), ZoneId.systemDefault()));
        feedBack.setProduct(bill.getProduct());
        feedBack.setCreateBy(customer.getName());
        feedBackRepository.save(feedBack);

        bill.setFeedback(true);
        billDetailRepository.save(bill);

        bill.getProduct().getFeedBacks().add(feedBack);
        productRepository.save(bill.getProduct());

    }
}

