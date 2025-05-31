package com.example.laptopaz.service.impl;

import com.example.laptopaz.domain.entity.Role;
import com.example.laptopaz.repository.RoleRepository;
import com.example.laptopaz.service.RoleService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class RoleServiceImpl implements RoleService {

    private final RoleRepository roleRepository;

    @Override
    public void initRoles() {
        if (roleRepository.count() == 0) {
            Role admin = Role.builder()
                    .roleName("ROLE_ADMIN")
                    .build();
            admin.setCreatedDate(LocalDateTime.now());
            admin.setLastModifiedDate(LocalDateTime.now());
            roleRepository.save(admin);

            Role user = Role.builder()
                    .roleName("ROLE_USER")
                    .build();
            user.setCreatedDate(LocalDateTime.now());
            user.setLastModifiedDate(LocalDateTime.now());
            roleRepository.save(user);
        }
    }
}
