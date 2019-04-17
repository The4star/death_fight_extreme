class Player
    def initialize(player_name)
        @player_name = player_name
        @health = 100
        @previous_scores = []
        @score_total = 0
    end
    def get_player_name
        @player_name
    end
    def set_player_name(player_name)
        @player_name = player_name
    end
    def get_health
        @health
    end
    def set_health(health)
        @health = health
    end
    def update_health(health_update_amount)
        @health += health_update_amount
    end
    def add_score(score)
        @scores << score
    end
    def get_scores
        @scores
    end

    def attack_with_axe(evilplayer_to_attack)
        attack_chance = Random.new
        attack_outcome = attack_chance.rand(1..20)
        if (attack_outcome % 3 == 0)
            puts ("#{@player_name} swings his Axe but narrowly misses #{evilplayer_to_attack.get_player_name}")
        else
            damage = Random.new
            damage_dealt = damage.rand(-15..-1)
            evilplayer_to_attack.update_health(damage_dealt)
            puts("#{@player_name} attacked #{evilplayer_to_attack.get_player_name} with an axe and dealt #{damage_dealt} damage")
            @previous_scores.push(200)
            puts ("#{@player_name} scored 200 points and their total score is now #{score_total}. #{evilplayer_to_attack.get_player_name}'s health is now #{evilplayer_to_attack.get_health}")
        end 
    end

    def attack_with_fist(evilplayer_to_attack)
        attack_chance = Random.new
        attack_outcome = attack_chance.rand(1..20)
        if (attack_outcome % 3 == 0)
            puts ("#{@player_name} strikes with fists of fury but #{evilplayer_to_attack.get_player_name} is too fast and the attack misses")
        else
            damage = Random.new
            damage_dealt = damage.rand(-10..-5)
            evilplayer_to_attack.update_health(damage_dealt)
            @previous_scores.push(100)
            puts("#{@player_name} attacked #{evilplayer_to_attack.get_player_name} with their fist and dealt #{damage_dealt} damage")
            puts ("#{@player_name} scored 100 points and their total score is now #{score_total}. #{evilplayer_to_attack.get_player_name}'s health is now #{evilplayer_to_attack.get_health}")
        end
    end

    def heal()
        if (@health.between?(0, 95))
            @health += 5
            puts ("#{@player_name} healed themself which gives them a 5 hp increase! #{@player_name}'s is now #{@health}")
        else
            puts ("#{@player_name}'s' health is already at a sufficient level and you cannot heal. \nYou just wasted a turn, noob!")
        end
    end

    def score_point(amount)
        print ("Player Scored!")
        @previous_scores.push(amount)
    end

    def score_total()
        total_score = 0
        @previous_scores.each do |findtotal|
           @score_total +=  findtotal
        end
        return @score_total
    end

    def to_s()
        "Player: \nPlayer name = #{@player_name} \n Health = #{@health} \nPrevious scores = #{@previous_scores} \nTotal Score = #{score_total}"
    end
end

class NonPlayerCharacter < Player
    def initialize(player_name, npc_level)
        super(player_name)
        @npc_level = npc_level
    end
    
    def get_npc_level
        @npc_level
    end
    
    def set_npc_level(npc_level)
        @npc_level = npc_level
    end

    def to_s()
        super.to_s + ("\n level = #{@npc_level}") 
    end

    def attack_with_axe(player_to_attack)
        attack_chance = Random.new
        attack_outcome = attack_chance.rand(1..20)
        if (attack_outcome % 3 == 0)
            puts ("#{@player_name} swings his Axe but narrowly misses #{player_to_attack.get_player_name}")
        else
            damage = Random.new
            damage_dealt = damage.rand(-15..-1)
            player_to_attack.update_health(damage_dealt)
            @previous_scores.push(200)
            puts("#{@player_name} attacked #{player_to_attack.get_player_name} with an axe and dealt #{damage_dealt} damage")
            puts ("#{@player_name} scored 200 points and their total score is now #{score_total}. #{player_to_attack.get_player_name}'s health is now #{player_to_attack.get_health}")
        end
    end
    def attack_with_fist(player_to_attack)
        attack_chance = Random.new
        attack_outcome = attack_chance.rand(1..20)
        if (attack_outcome % 3 == 0)
            puts ("#{@player_name} strikes with fists of fury but #{player_to_attack.get_player_name} is too fast and the attack misses")
        else
            damage = Random.new
            damage_dealt = damage.rand(-10..-5)
            player_to_attack.update_health(damage_dealt)
            @previous_scores.push(200)
            puts("#{@player_name} attacked #{player_to_attack.get_player_name} with their fists and dealt #{damage_dealt} damage")
            puts ("#{@player_name} scored 100 points and their total score is now #{score_total}. #{player_to_attack.get_player_name}'s health is now #{player_to_attack.get_health}")
        end
    end
    
end

class Game
    attr_reader(:players_in_game)
    def initialize
        @players_in_game = []
    end

    def add_players(player_to_add)
        @players_in_game.push(player_to_add)
    end
end

game1 = Game.new()

require 'artii'

a = Artii::Base.new :font => 'epic'
puts a.asciify('Death Fight Extreme') 


print("Welcome to the Battle Cage! \nPlayer one, choose your name:")
player_chosen_name = gets().chomp
player_1 = Player.new(player_chosen_name)
puts
puts ("Welcome #{player_1.get_player_name}. \n It's time to meet your opponent!")
puts
print("Player two, choose your name:")
second_player_chosen_name = gets().chomp
player_2 = NonPlayerCharacter.new(second_player_chosen_name, 100)
puts
puts ("welcome #{player_2.get_player_name} \n Now FIGHT TO THE DEATH!!")

def player_action(player1, player2)
    puts ("""
    It's your move #{player1.get_player_name}, what would you like to do?
    1. Attack #{player2.get_player_name} with fist
    2. Attack #{player2.get_player_name} with Axe
    3. Heal
    """
    )
    player_choice = gets().chomp.to_i

    case player_choice
    when 1
        player1.attack_with_fist(player2)
    when 2
        player1.attack_with_axe(player2)
    when 3
        player1.heal
    else
        puts("Please select an appropriate option")
    end


end

while player_1.get_health >= 1 and player_2.get_health >= 1
    
    if player_1.get_health <= 0
        puts
        death_string1 = ("#{player_1.get_player_name} has died a brutal death")
        a = Artii::Base.new :font => 'epic'
        puts a.asciify(death_string1) 
        puts ("#{player_2.get_player_name} is the winner with a total score of #{player_2.score_total}")
    else
    player_action(player_1, player_2)
    end

    if player_2.get_health <= 0
        puts
            death_string =("#{player_2.get_player_name} has died a brutal death")
            a = Artii::Base.new :font => 'epic'
            puts a.asciify(death_string) 
            puts ("#{player_1.get_player_name} is the winner with a total score of #{player_1.score_total}")
    else
    player_action(player_2, player_1)
    end
   

end
 
