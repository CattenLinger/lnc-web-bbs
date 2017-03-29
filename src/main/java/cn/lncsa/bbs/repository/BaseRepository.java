package cn.lncsa.bbs.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.NoRepositoryBean;

import java.io.Serializable;

/**
 * Created by catten on 3/29/17.
 */
@NoRepositoryBean
public interface BaseRepository<E,I extends Serializable> extends JpaRepository<E,I>, JpaSpecificationExecutor<E> {
}
