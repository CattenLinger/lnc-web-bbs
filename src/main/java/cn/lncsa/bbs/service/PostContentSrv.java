package cn.lncsa.bbs.service;

import cn.lncsa.bbs.exception.EntityNotFoundException;
import cn.lncsa.bbs.model.PostContent;
import cn.lncsa.bbs.repository.PostContentRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by catten on 3/29/17.
 */
@Service
public class PostContentSrv {

    private PostContentRepo postContentRepo;

    @Autowired
    public void setPostContentRepo(PostContentRepo postContentRepo) {
        this.postContentRepo = postContentRepo;
    }

    public void save(PostContent postContent){
        postContentRepo.save(postContent);
    }

    public PostContent get(Long postId) throws EntityNotFoundException {
        PostContent postContent = postContentRepo.findOne(postId);
        if(postContent == null) throw new EntityNotFoundException("No such post");
        return postContent;
    }

    public List<String> getAllTopics() {
        return postContentRepo.getAllTopics();
    }
}
