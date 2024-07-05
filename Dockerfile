# Utiliser une image Ruby officielle
FROM ruby:2.7

# Installer les dépendances de l'application
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Définir le répertoire de travail de l'application
WORKDIR /app

# Copier le Gemfile et Gemfile.lock et installer les gemmes
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install

# Copier le reste de l'application
COPY . /app

# Précompiler les assets (si nécessaire)
RUN bundle exec rake assets:precompile

# Exposer le port de l'application
EXPOSE 3000

# Définir la commande pour démarrer l'application
CMD ["rails", "server", "-b", "0.0.0.0"]