package com.aiq.editor.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ArticleRepository extends JpaRepository<Article, Long> {
    @Query(value = "select u from Article u where u.title=?1 and u.userId=?2")
    List<Article> find(String title, String userId);

    List<Article> findArticlesByUserIdIs(String userId);
}
